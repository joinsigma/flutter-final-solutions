import 'package:shared_preferences/shared_preferences.dart';

/// Todo 8: Use shared preference to store token
///   - Store auth token
///   - check if user has logged in
///   - install shared_preferences package using [ flutter pub add shared_preferences ]
class LocalStorageService {
  static const sharedPrefAuthTokenKey = 'authToken';
  static const sharedPrefRefreshTokenKey = 'refreshToken';
  static const sharedPrefEmailKey = 'email';
  static const sharedPrefPasswordKey = 'password';

  // Save auth token
  Future<bool> saveUserToken(String idToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    final isAuthSaved = await prefs.setString(sharedPrefAuthTokenKey, idToken);
    final isRefreshSaved =
        await prefs.setString(sharedPrefRefreshTokenKey, refreshToken);
    return isAuthSaved && isRefreshSaved;
  }

  // Get auth token
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString(sharedPrefAuthTokenKey);
    return authToken;
  }

  // Delete auth token on logout
  Future<bool> deleteUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuthTokenDeleted = await prefs.remove(sharedPrefAuthTokenKey);
    final isRefreshTokenDeleted = await prefs.remove(sharedPrefRefreshTokenKey);
    return isAuthTokenDeleted && isRefreshTokenDeleted;
  }
}
