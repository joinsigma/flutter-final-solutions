import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const sharedPrefTokenKey = 'token';
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

  void updateAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final isSaved = await prefs.setString(sharedPrefTokenKey, token);
    if (!isSaved) {
      throw AuthTokenErrorException();
    }
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
}

class AuthTokenErrorException implements Exception {}
