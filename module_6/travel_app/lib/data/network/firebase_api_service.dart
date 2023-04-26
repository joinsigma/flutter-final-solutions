import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/booking_detail.dart';
import '../model/detail_package.dart';
import '../model/package.dart';

class FirebaseApiService {
  ///New user registration
  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  ///Existing User login
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
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
      {required BookingDetail booking, required int totalPrice}) async {
    CollectionReference bookings =
        FirebaseFirestore.instance.collection('bookings');
    await bookings.add({
      'package_id': booking.packageId,
      'package_title': booking.packageTitle,
      'partner_name': booking.partnerName,
      'user_id': booking.userId,
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
}
