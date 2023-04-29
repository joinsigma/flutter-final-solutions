import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_app/data/model/user.dart';
import 'package:travel_app/data/network/exceptions.dart';
import 'package:uuid/uuid.dart';

import '../model/booking_detail.dart';
import '../model/detail_package.dart';
import '../model/package.dart';
import 'dart:io';

class FirebaseApiService {
  ///New user registration
  Future<String?> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user?.uid;
      // // return UserBasic(uid: result.user.uid, token: result.credential.accessToken);
      // result.credential.token;
      // result.user.uid;
      //
      // return 'Success';
    } on FirebaseAuthException catch (e) {
      throw UserRegistrationException('Register Error');
    }
    // on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     return 'The password provided is too weak.';
    //   } else if (e.code == 'email-already-in-use') {
    //     return 'The account already exists for that email.';
    //   } else {
    //     return e.message;
    //   }
    // } catch (e) {
    //   return e.toString();
    // }
  }

  ///Existing User login
  Future<String?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user?.uid;
    } on FirebaseAuthException catch (e) {
      throw UserLoginException('Login Error');
    }
    // on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     return 'No user found for that email.';
    //   } else if (e.code == 'wrong-password') {
    //     return 'Wrong password provided for that user.';
    //   } else {
    //     return e.message;
    //   }
    // }
    // catch (e) {
    //   return e.toString();
    // }
  }

  ///Existing User logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  ///Get list of travel packages
  Future<List<Package>> getPackages() async {
    CollectionReference packages =
        FirebaseFirestore.instance.collection('packages');
    final result = await packages.get();
    List<Package> pkgs = [];

    for (var doc in result.docs) {
      final package = Package(
          id: doc.id,
          title: doc['title'],
          location: doc['location'],
          imgUrl: doc['main_img_url'],
          price: doc['price_per_pax'],
          tags: List<String>.from(doc['tags']));
      pkgs.add(package);
    }
    return pkgs;
  }

  ///Get a travel package in detail
  Future<DetailPackage> getDetailPackage(String id) async {
    CollectionReference packages =
        FirebaseFirestore.instance.collection('packages');
    final result = await packages.doc(id).get();

    final detailPackage = DetailPackage(
        id: result.id,
        title: result['title'],
        description: result['description'],
        mealInfo: result['meal_info'],
        location: result['location'],
        imgUrls: List<String>.from(result['extra_img_url']),
        price: result['price_per_pax'],
        partnerName: result['partner_name'],
        rating: result['rating'],
        itineraries: result['itinerary']
            .map<Itinerary>((json) => Itinerary(
                title: json['title'], description: json['description']))
            .toList(),
        tags: List<String>.from(result['tags']));
    return detailPackage;
  }

  ///Get a booking info in detail
  Future<List<BookingDetail>> getBookings(String userId) async {
    CollectionReference packages =
        FirebaseFirestore.instance.collection('bookings');
    final result = await packages.where('user_id', isEqualTo: userId).get();

    List<BookingDetail> bookings = [];

    for (var doc in result.docs) {
      final booking = BookingDetail(
          id: doc.id,
          packageId: doc['package_id'],
          partnerName: doc['partner_name'],
          packageTitle: doc['package_title'],
          userId: doc['user_id'],
          email: doc['email'],
          custFirstName: doc['first_name'],
          custLastName: doc['last_name'],
          mobileNo: doc['mobile_no'],
          billingAddress: doc['billing_address'],
          numPax: doc['num_pax'],
          createdAt: doc['created_at'].toDate(),
          startDate: doc['start_date'].toDate(),
          endDate: doc['end_date'].toDate(),
          imageUrl: doc['image_url'],
          totalPrice: doc['total_price'],
          status: doc['status'] == 'ACTIVE'
              ? BookingStatus.active
              : BookingStatus.cancelled
          // status: doc['status'] == 'ACTIVE'
          //     ? BookingStatus.active
          //     : doc['status'] == 'COMPLETED'
          //         ? BookingStatus.completed
          //         : BookingStatus.cancelled
          );
      bookings.add(booking);
    }
    return bookings;
  }

  ///Create a new booking for user
  Future<void> createNewBooking(
      {required BookingDetail booking,
      required int totalPrice,
      required String uid}) async {
    CollectionReference bookings =
        FirebaseFirestore.instance.collection('bookings');
    final result = await bookings.add({
      'package_id': booking.packageId,
      'package_title': booking.packageTitle,
      'partner_name': booking.partnerName,
      // 'user_id': booking.userId,
      'user_id': uid,
      'first_name': booking.custFirstName,
      'last_name': booking.custLastName,
      'email': booking.email,
      'mobile_no': booking.mobileNo,
      'billing_address': booking.billingAddress,
      'num_pax': booking.numPax,
      'start_date': booking.startDate,
      'end_date': booking.endDate,
      'created_at': booking.createdAt,
      'total_price': totalPrice,
      'image_url': booking.imageUrl,
      'status': 'ACTIVE'
    });

    ///Add booking id under user info. This is to calculate number of trips in profile section.
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(uid).update({
      'bookings': FieldValue.arrayUnion([result.id])
    });
  }

  Future<void> cancelBooking(String bookingId) async {
    CollectionReference bookings =
        FirebaseFirestore.instance.collection('bookings');
    await bookings.doc(bookingId).update({'status': 'CANCELLED'});
  }

  Future<bool> isPackageLikedByUser(String userId, String packageId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = await users.doc(userId).get();

    ///Initial likes array must be empty not null
    final likes = List<String>.from(user['likes']);
    return likes.contains(packageId) ? true : false;
  }

  Future<void> addPackageToUserLikes({
    required String userId,
    required String packageId,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    ///If your document contains an array field, you can use arrayUnion()
    /// and arrayRemove() to add and remove elements.
    /// arrayUnion() adds elements to an array but only elements not already present. arrayRemove() removes all instances of each given element.
    await users.doc(userId).update({
      'likes': FieldValue.arrayUnion([packageId])
    });
  }

  // Future<void> addPackageToUserLikes(
  //     {required String userId,
  //     required String packageId,
  //     required String location,
  //     required int pricePerPax,
  //     required String title}) async {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //
  //   ///If your document contains an array field, you can use arrayUnion()
  //   /// and arrayRemove() to add and remove elements.
  //   /// arrayUnion() adds elements to an array but only elements not already present. arrayRemove() removes all instances of each given element.
  //   final like = <String, dynamic>{
  //     'package_id': packageId,
  //     'title': title,
  //     'location': location,
  //     'price_per_pax': pricePerPax,
  //   };
  //   await users.doc(userId).update({
  //     'likes': FieldValue.arrayUnion([like])
  //   });
  // }

  Future<void> removePackageFromUserLikes({
    required String userId,
    required String packageId,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.doc(userId).update({
      'likes': FieldValue.arrayRemove([packageId])
    });
  }

  Future<List<Package>> getLikedPackagesByUser(String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference packages =
        FirebaseFirestore.instance.collection('packages');

    ///Get user info
    final result = await users.doc(userId).get();

    ///Query package details based on ids that are liked by user
    List<dynamic> ids = result['likes'];
    if (ids.isEmpty) return [];
    final likes =
        await packages.where(FieldPath.documentId, whereIn: ids).get();
    List<Package> pkgs = [];

    for (var doc in likes.docs) {
      final package = Package(
          id: doc.id,
          title: doc['title'],
          location: doc['location'],
          imgUrl: doc['main_img_url'],
          price: doc['price_per_pax'],
          tags: List<String>.from(doc['tags']));
      pkgs.add(package);
    }
    return pkgs;
  }

  ///Initialize user details after new registration
  Future<void> initializeUserInfo(
      {required String email, required String uid}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    ///Use set operation instead of add, to make sure uid from FirebaseAuth is the same as Doc id.
    await users.doc(uid).set({
      'bookings': [],
      'likes': [],
      'email': email,
      'profile_name': "user",
      'profile_img_url': "",
      'mobile_no': "",
      'billing_address': "",
      'created_at': DateTime.now(),
    });
  }

  Future<UserDetail> getUserDetail(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final result = await users.doc(uid).get();
    final user = UserDetail(
        uid: result.id,
        name: result['profile_name'],
        imageUrl: result['profile_img_url'],
        email: result['email'],
        mobileNum: result['mobile_no'],
        address: result['billing_address'],
        numLikes: List<String>.from(result['likes']).length,
        numTrips: List<String>.from(result['bookings']).length);
    print(result['likes']);
    print('numlikes;${user.numLikes}');
    return user;
  }

  Future<String> uploadProfileImage(File imgFile) async {
    final storageRef = FirebaseStorage.instance.ref();
    var uuid = const Uuid();
    final profileImageRef = storageRef.child("profile-images/${uuid.v4()}.jpg");
    try {
      await profileImageRef.putFile(imgFile);
      final url = await profileImageRef.getDownloadURL();
      return url;
    } catch (e) {
      throw ProfileImageUploadException();
    }
  }

  Future<void> updateProfileImageUrl(
      {required String uid, required String url}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(uid).update({'profile_img_url': url});
  }

  Future<void> updateUserProfile({
    required String uid,
    required String name,
    required String email,
    required String address,
    required String mobileNum,
  }) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    await users.doc(uid).update({
      'email': email,
      'profile_name': name,
      'mobile_no': mobileNum,
      'billing_address': address,
    });
  }
}
