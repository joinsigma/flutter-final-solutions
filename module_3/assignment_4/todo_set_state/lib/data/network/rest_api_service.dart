import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_set_state/data/storage/local_storage_service.dart';

import '../model/todo.dart';
import '../model/user.dart';
import 'exceptions.dart';

class RestApiService {
  static const String registerUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA5iSaDunKCBNiUWifV61EOVX331pkI3SA';
  static const String loginUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA5iSaDunKCBNiUWifV61EOVX331pkI3SA";
  static const String refreshTokenUrl =
      "https://securetoken.googleapis.com/v1/token?key=AIzaSyA5iSaDunKCBNiUWifV61EOVX331pkI3SA";

  static const String todoApiBaseUrl =
      "https://asia-southeast1-flutter-todo-a2430.cloudfunctions.net/user/todos";
  static const headers = {'Content-Type': 'application/json'};

  /// API call for new user registration
  // New user registration
  Future<User> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
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
      throw UserRegistrationError(
          'An account has been registered under this email');
    } else {
      throw UserRegistrationError(
        'API Error during user registration',
      );
    }
  }

  /// API call for authenticating existing user
  // User sign-in using email/password
  Future<User> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
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
        throw UserLoginError('Invalid password');
      } else if (errorCode == 'EMAIL_NOT_FOUND') {
        throw UserLoginError('Account not exist with the provided email');
      }
      throw UserLoginError('API Error during user sign-in process');
    }
    throw UserLoginError('API Error during user sign-in process');
  }

  Future<String> refreshSession(String refreshToken) async {
    final response = await http.post(
      Uri.parse(refreshTokenUrl),
      headers: headers,
      body: jsonEncode(
        {
          'grant_type': "refresh_token",
          'refreshToken': refreshToken,
        },
      ),
    );

    final raw = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return raw['access_token'];
    } else {
      print(refreshToken);
      print(response.statusCode);
      print(response.body);
      throw UserRefreshSessionError();
    }
  }

  /// API call to retrieve all todos for a particular user.
  Future<List<Todo>> getAllTodos() async {
    ///Get token from local storage.
    final localStorageService = LocalStorageService();
    final token = await localStorageService.getAuthToken();

    final response = await http.get(
      Uri.parse(todoApiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final raw = jsonDecode(response.body);
      List<Todo> todos = raw.map<Todo>((data) => Todo.fromJson(data)).toList();
      return todos;
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      print(response.statusCode);
      throw GetAllTodosError('API Error getting all todos');
    }
  }

  ///API call to retrieve a todos by ID.
  Future<Todo> getTodoById({required String token, required Todo todo}) async {
    ///Get token from local storage.
    final localStorageService = LocalStorageService();
    final token = await localStorageService.getAuthToken();

    final response = await http.get(
      Uri.parse('$todoApiBaseUrl/${todo.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final raw = jsonDecode(response.body);
      return Todo.fromJson(raw);
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      throw GetTodoError('API Error getting todo id: ${todo.id}');
    }
  }

  /// API call to add a new todos for a particular user.
  Future<Todo> addNewTodo({required String token, required Todo todo}) async {
    final response = await http.post(
      Uri.parse(todoApiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      //Todo: repair here.
      body: jsonEncode(<String, dynamic>{"description": ''}),
    );

    if (response.statusCode == 201) {
      final raw = jsonDecode(response.body)['data'];
      return Todo.fromJson(raw);
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      throw AddTodoError('API Error add new todo');
    }
  }

  /// API call to update an existing todos for a particular user.
  Future<bool> updateTodo({required String token, required Todo todo}) async {
    final response = await http.put(
      Uri.parse('$todoApiBaseUrl/${todo.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },

      ///Todo: repair here.
      body: jsonEncode(<String, dynamic>{
        "title": todo.title,
        "description": todo.description,
        "createdAt": todo.createdAt.toString(),
        "updatedAt": todo.updatedAt.toString(),
        "deadline": todo.deadline.toString(),
        "priority": todo.priority == Priority.high
            ? "HIGH"
            : todo.priority == Priority.medium
                ? "MEDIUM"
                : "LOW"
      }),
    );

    print(todo.description);
    if (response.statusCode == 200) {
      // final raw = jsonDecode(response.body)['data'];
      return true;
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      throw UpdateTodoError('API Error to update edited todo');
    }
  }

  /// API call to update todos completion status.
  Future<bool> updateTodoStatus(
      {required String token,
      required String id,
      required bool isCompleted}) async {
    final response = await http.put(
      Uri.parse('$todoApiBaseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{"isCompleted": isCompleted}),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      throw UpdateTodoError('API Error to update todo completion status.');
    }
  }

  /// API call to delete a todos for a particular user.
  Future<bool> deleteTodo({required String token, required String id}) async {
    print('$todoApiBaseUrl/$id');
    final response = await http.delete(
      Uri.parse('$todoApiBaseUrl/$id'),
      headers: {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    print(response);
    if (response.statusCode == 200) {
      print('deleted');
      print(response.body);
      return true;
      // final raw = jsonDecode(response.body)['data'];
      // return Todo.fromJson(raw);
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      throw DeleteTodoError('API Error delete todo id: $id');
    }
  }
}
