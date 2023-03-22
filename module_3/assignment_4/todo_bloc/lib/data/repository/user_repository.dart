import 'package:flutter_todo_bloc/data/network/rest_api_service.dart';
import 'package:flutter_todo_bloc/data/repository/base_repository.dart';
import 'package:flutter_todo_bloc/data/storage/local_storage_service.dart';

import '../model/user.dart';
import 'exceptions.dart';

class UserRepository extends BaseRepository {
  final RestApiService _restApiService;
  final LocalStorageService _localStorageService;

  UserRepository(this._restApiService, this._localStorageService);

  late bool _isConnected;

  Future<void> loginUser(
      {required String email, required String password}) async {
    _isConnected = await isConnectedToInternet();
    if (!_isConnected) throw NoInternetConnectionException();

    final user = await _restApiService.signInUsingEmailPassword(
        email: email, password: password);

    _localStorageService.saveToken(user.authToken);
    _localStorageService.saveUserId(user.uid);
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    _isConnected = await isConnectedToInternet();
    if (!_isConnected) throw NoInternetConnectionException();

    final user = await _restApiService.registerWithEmailPassword(
        email: email, password: password);

    _localStorageService.saveToken(user.authToken);
    _localStorageService.saveUserId(user.uid);
  }

  Future<bool> isUserLoggedIn() async {
    try {
      final result = await _localStorageService.getAuthToken();
      return result.isNotEmpty;
    } on NoAuthTokenFoundException catch (_) {
      return false;
    }
  }

  Future<String> getUserId() async {
    final uid = await _localStorageService.getUserId();
    return uid;
  }

  void deleteUserToken() async {
    _localStorageService.deleteToken();
  }

  void deleteUserId() async {
    _localStorageService.deleteUserId();
  }
}
