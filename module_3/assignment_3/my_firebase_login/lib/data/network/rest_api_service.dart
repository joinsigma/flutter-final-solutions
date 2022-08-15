import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_firebase_login/data/data.dart';
import 'package:my_firebase_login/data/model/user.dart';
import 'package:my_firebase_login/data/network/exceptions.dart';

/// Todo 7: Create API calls for user authentication using Firebase Auth
///   - Login
///   - Registration

class RestApiService {
  static const String firebaseAuthEndpoint = 'https://identitytoolkit.googleapis.com/v1';
  static const headers = {'Content-Type': 'application/json'};

  // New user registration
  Future<User> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    const url = '$firebaseAuthEndpoint/accounts:signUp?key=$firebaseApiKey';

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final raw = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(raw);
    } else if (response.statusCode == 400 &&
        raw['error']['message'] == 'EMAIL_EXISTS') {
      throw UserRegistrationError(
          'An account has been registered under this email');
    } else {
      throw UserRegistrationError(
        'API Error during user registration',
      );
    }
  }

  // User sign-in using email/password
  Future<User> signInUsingEmailPassword(
    String email,
    String password,
  ) async {
    const url =
        '$firebaseAuthEndpoint/accounts:signInWithPassword?key=$firebaseApiKey';

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final raw = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(raw);
    } else if (response.statusCode == 400) {
      final errorCode = raw['error']['message'];
      if (errorCode == 'INVALID_PASSWORD') {
        throw UserLoginError('Invalid password');
      } else if (errorCode == 'EMAIL_NOT_FOUND') {
        throw UserLoginError('Account not exist with the provided email');
      }
      throw UserLoginError('API Error during user sign-in process');
    }
    throw UserLoginError('API Error during user sign-in process');
  }
}
