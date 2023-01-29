import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/todo.dart';
import '../model/user.dart';
import 'exceptions.dart';

class RestApiService {
  static const String registerUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA5iSaDunKCBNiUWifV61EOVX331pkI3SA';
  static const String loginUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA5iSaDunKCBNiUWifV61EOVX331pkI3SA";

  // static const String baseLink = "https://api-nodejs-todolist.herokuapp.com";

  static const String todoApiBaseUrl =
      "https://asia-southeast1-flutter-todo-a2430.cloudfunctions.net/user/todos";
  static const headers = {'Content-Type': 'application/json'};

  /// API call for new user registration
  // New user registration
  Future<User> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(registerUrl),
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

  /// API call for authenticating existing user
  // User sign-in using email/password
  Future<User> signInUsingEmailPassword(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(loginUrl),
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

  /// API call to retrieve all todos for a particular user.
  Future<List<Todo>> getAllTodos(String token) async {
    final response = await http.get(
      Uri.parse(todoApiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final List raw = jsonDecode(response.body)['data'];
      List<Todo> todos = raw.map((data) => Todo.fromJson(data)).toList();
      return todos;
    } else {
      throw GetAllTodosError('API Error getting all todos');
    }
  }

  /// API call to add a new todos for a particular user.
  Future<Todo> addNewTodo(String token, Todo todo) async {
    final response = await http.post(
      Uri.parse(todoApiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      //Todo: repair here.
      body: jsonEncode(<String, String>{"description": ''}),
    );

    if (response.statusCode == 201) {
      final raw = jsonDecode(response.body)['data'];
      return Todo.fromJson(raw);
    } else {
      throw AddTodoError('API Error add new todo');
    }
  }

  /// API call to update an existing todos for a particular user.
  Future<Todo> updateTodo(String token,Todo todo) async {
    final response = await http.put(
      Uri.parse(todoApiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      ///Todo: repair here.
      body: jsonEncode(<String, String>{"description":''}),
    );

    if (response.statusCode == 201) {
      final raw = jsonDecode(response.body)['data'];
      return Todo.fromJson(raw);
    } else {
      throw AddTodoError('API Error add new todo');
    }
  }

  /// API call to delete a todos for a particular user.
  Future<Todo> deleteTodo(String token,String id) async {
    final response = await http.put(
      Uri.parse(todoApiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      ///Todo: repair here.
      body: jsonEncode(<String, String>{"description":''}),
    );

    if (response.statusCode == 201) {
      final raw = jsonDecode(response.body)['data'];
      return Todo.fromJson(raw);
    } else {
      throw AddTodoError('API Error add new todo');
    }
  }
}
