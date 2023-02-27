import 'dart:convert';

import 'package:flutter_todo_bloc/data/storage/local_storage_service.dart';
import 'package:http/http.dart' as http;

import '../model/todo.dart';
import '../model/user.dart';
import 'exceptions.dart';

class RestApiService {
  static const String registerUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA5iSaDunKCBNiUWifV61EOVX331pkI3SA';
  static const String loginUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA5iSaDunKCBNiUWifV61EOVX331pkI3SA";

  static const String todoApiBaseUrl =
      "https://asia-southeast1-flutter-todo-a2430.cloudfunctions.net/user/todos";

  static const headers = {'Content-Type': 'application/json'};

  ///API call for new user registration
  Future<User> registerWithEmailPassword(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: headers,
      body: jsonEncode(
          {"email": email, "password": password, "returnSecureToken": true}),
    );

    final raw = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(raw);
    } else {
      throw UserRegistrationError("API Error during user registration");
    }
  }

  ///API call for authenticating exiting user
  Future<User> signInUsingEmailPassword(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: headers,
      body: jsonEncode(
          {"email": email, "password": password, "returnSecureToken": true}),
    );

    final raw = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(raw);
    } else {
      throw UserLoginError("API Error during user registration");
    }
  }

  ///API call to retrieve all todos for a particular user
  Future<List<Todo>> getAllTodos() async {
    ///Get token from the local storage
    final localStorageService = LocalStorageService();
    final token = await localStorageService.getAuthToken();

    final response = await http.get(Uri.parse(todoApiBaseUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final raw = jsonDecode(response.body);
      List<Todo> todos = raw.map<Todo>((data) => Todo.fromJson(data)).toList();
      return todos;
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      throw GetAllTodosError('API Error getting all todos');
    }
  }

  ///API call to add a new todos for a particular user
  Future<bool> addNewTodo(Todo todo) async {
    ///Get token from the local storage
    final localStorageService = LocalStorageService();
    final token = await localStorageService.getAuthToken();

    final response = await http.post(
      Uri.parse(todoApiBaseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        <String, dynamic>{
          "userId": todo.userId,
          "title": todo.title,
          "description": todo.description,
          "createdAt": todo.createdAt.toString(),
          "updatedAt": todo.updatedAt.toString(),
          "deadline": todo.deadline.toString(),
          "priority": todo.priority == Priority.high
              ? "HIGH"
              : todo.priority == Priority.medium
              ? "MEDIUM"
              : "LOW",
          "isCompleted": todo.isCompleted
        },
      ),
    );

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      print(response.body);
      throw AddTodoError('API Error add new todo');
    }
  }

  ///API call to update todos completion status
  Future<bool> updateTodoStatus(
      {required String id, required bool isCompleted}) async {
    ///Get token from the local storage
    final localStorageService = LocalStorageService();
    final token = await localStorageService.getAuthToken();

    final response = await http.put(Uri.parse('$todoApiBaseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{"isCompleted": isCompleted}));

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      throw UpdateTodoError('API Error to update todo completion status');
    }
  }

  ///API call to delete a todos for a particular user
  Future<bool> deleteTodo(String id) async {
    ///Get token from the local storage
    final localStorageService = LocalStorageService();
    final token = await localStorageService.getAuthToken();

    final response = await http.delete(
      Uri.parse('$todoApiBaseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      throw DeleteTodoError('API Error to delete todo');
    }
  }

  /// API call to update an existing todos for a particular user
  Future<bool> updateTodo(Todo todo) async {
    ///Get token from the local storage
    final localStorageService = LocalStorageService();
    final token = await localStorageService.getAuthToken();

    final response = await http.put(
      Uri.parse('$todoApiBaseUrl/${todo.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        <String, dynamic>{
          "title": todo.title,
          "description": todo.description,
          "createdAt": todo.createdAt.toString(),
          "updatedAt": todo.updatedAt.toString(),
          "deadline": todo.deadline.toString(),
          "priority": todo.priority == Priority.high
              ? "HIGH"
              : todo.priority == Priority.medium
              ? "MEDIUM"
              : "LOW",
          "isCompleted": todo.isCompleted
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw NotAuthorizedError();
    } else {
      throw UpdateTodoError('API Error to update edited todo');
    }
  }
}
