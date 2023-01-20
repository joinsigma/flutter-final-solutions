import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';

class RestApiService {
  static const String signUpUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA5iSaDunKCBNiUWifV61EOVX331pkI3SA';
  static const String signInUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA5iSaDunKCBNiUWifV61EOVX331pkI3SA";

  static const headers = {'Content-Type': 'application/json'};

  // New user registration
  Future<User> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(signUpUrl),
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
      throw Exception('An account has been registered under this email');
    } else {
      throw Exception(
        'API Error during user registration',
      );
    }
  }

  // User sign-in using email/password
  Future<User> signInUsingEmailPassword(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(signInUrl),
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
        throw Exception('Invalid password');
      } else if (errorCode == 'EMAIL_NOT_FOUND') {
        throw Exception('Account not exist with the provided email');
      }
      throw Exception('API Error during user sign-in process');
    }
    throw Exception('API Error during user sign-in process');
  }

  ///Todo 1: Challenge: Refresh token
}
