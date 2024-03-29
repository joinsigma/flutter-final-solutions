import 'dart:io';

import 'package:travel_app/data/network/firebase_api_service.dart';

import '../model/user.dart';
import '../storage/exceptions.dart';
import '../storage/local_storage_service.dart';

class UserRepository {
  final FirebaseApiService _firebaseApiService;
  final LocalStorageService _localStorageService;

  UserRepository(this._firebaseApiService, this._localStorageService);

  Future<void> loginUser(
      {required String email, required String password}) async {
    final uid = await _firebaseApiService.loginWithEmailPassword(
        email: email, password: password);

    if (uid != null) {
      _localStorageService.saveUserId(uid);
    } else {
      throw UidException();
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    final uid = await _firebaseApiService.registerWithEmailPassword(
        email: email, password: password);

    if (uid != null) {
      _localStorageService.saveUserId(uid);
    } else {
      throw UidException();
    }

    ///Initialize user firestore
    await _firebaseApiService.initializeUserInfo(email: email, uid: uid);
  }

  Future<bool> isUserLoggedIn() async {
    try {
      final result = await _localStorageService.getUserId();
      return result.isNotEmpty;
    } on NoUidFoundException catch (_) {
      return false;
    }
  }

  ///For logout feature
  void deleteUserId() async {
    _localStorageService.deleteUserId();
  }

  Future<UserDetail> fetchUserDetail() async {
    final uid = await _localStorageService.getUserId();
    final result = await _firebaseApiService.getUserDetail(uid);
    return result;
  }

  Future<void> saveNewProfileImage(File profileImage) async {
    ///Get user id
    final uid = await _localStorageService.getUserId();

    ///Upload to firebase storage
    final newImgUrl =
        await _firebaseApiService.uploadProfileImage(profileImage);

    ///update user profile
    await _firebaseApiService.updateProfileImageUrl(uid: uid, url: newImgUrl);
  }

  Future<void> updateUserProfile(
      {required String name,
      required String address,
      required String mobileNum,
      required String email}) async {
    final uid = await _localStorageService.getUserId();
    await _firebaseApiService.updateUserProfile(
        uid: uid,
        name: name,
        email: email,
        address: address,
        mobileNum: mobileNum);
  }
}
