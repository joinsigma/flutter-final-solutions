import 'package:my_firebase_login/data/network/rest_api_service.dart';
import 'package:my_firebase_login/data/storage/local_storage_service.dart';

/// Todo 9: Create user repository that handle Login & Registration API call
///   - store authToken & refreshToken if registered / logged in successfully
///   - throw error if the process is failed
///   - 3 operations: check whether user has logged in previously, login user, register new user
///

class UserRepository {
  final RestApiService _restApiService;
  final LocalStorageService _localStorageService;

  UserRepository(this._restApiService, this._localStorageService);

  // Check whether user has logged in
  Future<bool> isUserLoggedIn() async {
    final authToken = await _localStorageService.getAuthToken();
    if (authToken == null) {
      return false;
    } else {
      return true;
    }
  }

  // Register new user
  Future<void> registerUser(String email, String password) async {
    final user = await _restApiService.registerWithEmailPassword(
      email,
      password,
    );
    // If success, save token
    _localStorageService.saveUserToken(user.authToken, user.refreshToken);
  }

  // Login user
  Future<void> loginExistingUser(String email, String password) async {
    final user = await _restApiService.signInUsingEmailPassword(
      email,
      password,
    );
    // If success, save latest token
    _localStorageService.saveUserToken(user.authToken, user.refreshToken);
  }
}
