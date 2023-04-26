import 'package:travel_app/data/network/firebase_api_service.dart';

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
  void deleteUserId() async {
    _localStorageService.deleteUserId();
  }
}
