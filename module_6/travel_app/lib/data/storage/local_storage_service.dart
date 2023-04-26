import 'package:shared_preferences/shared_preferences.dart';

import 'exceptions.dart';

class LocalStorageService {
  static const sharedPrefTokenKey = 'token';
  static const sharedPrefUidKey = 'userId';

  ///Save Auth Token
  void saveToken(String authToken) async {
    final prefs = await SharedPreferences.getInstance();
    final isAuthTokenSaved =
        await prefs.setString(sharedPrefTokenKey, authToken);

    if (!isAuthTokenSaved) {
      throw AuthTokenException();
    }
  }

  ///Saver User Id
  void saveUserId(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    final isUserIdSaved = await prefs.setString(sharedPrefUidKey, uid);
    if (!isUserIdSaved) {
      throw UidException();
    }
  }

  ///getAuthToken
  Future<String> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(sharedPrefTokenKey);
    if (authToken == null) {
      throw NoAuthTokenFoundException();
    }
    return authToken;
  }

  ///getUserId
  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(sharedPrefUidKey);
    if (uid == null) {
      throw NoUidFoundException();
    }
    return uid;
  }

  /// delete Auth Token
  void deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuthTokenRemoved = await prefs.remove(sharedPrefTokenKey);
    if (!isAuthTokenRemoved) {
      throw AuthTokenException();
    }
  }

  /// deleteUserId
  void deleteUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final isUserIdRemoved = await prefs.remove(sharedPrefUidKey);
    if (!isUserIdRemoved) {
      throw UidException();
    }
  }
}
