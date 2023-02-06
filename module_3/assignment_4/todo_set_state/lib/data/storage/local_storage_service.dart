import 'package:shared_preferences/shared_preferences.dart';

import 'exceptions.dart';

class LocalStorageService {
  static const sharedPrefTokenKey = 'token';
  static const sharedPrefUidKey = 'userId';
  static const sharedPrefRefreshTokenKey = 'refreshToken';
  static const sharedFirstTimeKey = 'isFirstTime';
  static const sharedEmailKey = 'email';
  static const sharedPasswordKey = 'password';

  //Todo: revisit this implementation to return bool value based on save result (true/false).

  void saveToken(
      {required String authToken, required String refreshToken}) async {
    final prefs = await SharedPreferences.getInstance();
    final isAuthTokenSaved =
        await prefs.setString(sharedPrefTokenKey, authToken);
    final isRefreshTokenSaved =
        await prefs.setString(sharedPrefRefreshTokenKey, refreshToken);
    if (isAuthTokenSaved && isRefreshTokenSaved == false) {
      throw AuthTokenErrorException();
    }
  }

  void saveUserId(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    final isUserIdSaved = await prefs.setString(sharedPrefUidKey, uid);
    if (isUserIdSaved == false) {
      throw UidErrorException();
    }
  }

  Future<bool> updateAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final isSaved = await prefs.setString(sharedPrefTokenKey, token);
    return isSaved;
  }

  void saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final isSaved = await prefs.setString(sharedPrefRefreshTokenKey, token);
    if (!isSaved) {
      throw AuthTokenErrorException();
    }
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(sharedPrefTokenKey);
    return authToken;
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(sharedPrefUidKey);
    return uid;
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString(sharedPrefRefreshTokenKey);
    return refreshToken;
  }

  void deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuthTokenRemoved = await prefs.remove(sharedPrefTokenKey);
    final isRefreshTokenRemoved = await prefs.remove(sharedPrefRefreshTokenKey);
    if (isAuthTokenRemoved && isRefreshTokenRemoved == false) {
      throw AuthTokenErrorException();
    }
  }

  void deleteUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final isUserIdRemoved = await prefs.remove(sharedPrefUidKey);
    if (isUserIdRemoved == false) {
      throw UidErrorException();
    }
  }
}


