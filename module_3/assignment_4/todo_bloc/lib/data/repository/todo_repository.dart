import 'package:flutter_todo_bloc/data/network/rest_api_service.dart';
import 'package:flutter_todo_bloc/data/repository/base_repository.dart';

import '../model/todo.dart';
import '../storage/local_storage_service.dart';
import 'exceptions.dart';

class TodoRepository extends BaseRepository {
  final RestApiService _restApiService;
  final LocalStorageService _localStorageService;

  TodoRepository(this._restApiService, this._localStorageService);

  late String? _token;
  late bool _isConnected;

  Future<List<Todo>> getMyTodos() async {
    _isConnected = await isConnectedToInternet();
    if (!_isConnected) throw NoInternetConnectionException();

    _token = await _localStorageService.getAuthToken();
    if (_token == null) throw NoAuthTokenFoundException();
    final result = await _restApiService.getAllTodos(_token!);
    return result;
  }

  Future<bool> addNewTodo(Todo todo) async {
    _isConnected = await isConnectedToInternet();
    if (!_isConnected) throw NoInternetConnectionException();
    _token = await _localStorageService.getAuthToken();
    if (_token == null) throw NoAuthTokenFoundException();
    final result = await _restApiService.addNewTodo(todo: todo, token: _token!);
    return result;
  }

  Future<bool> editTodo(Todo todo) async {
    _isConnected = await isConnectedToInternet();
    if (!_isConnected) throw NoInternetConnectionException();
    _token = await _localStorageService.getAuthToken();
    if (_token == null) throw NoAuthTokenFoundException();
    final result = await _restApiService.updateTodo(todo: todo, token: _token!);
    return result;
  }

  Future<bool> updateTodoStatus(
      {required String id, required bool isCompleted}) async {
    _isConnected = await isConnectedToInternet();
    if (!_isConnected) throw NoInternetConnectionException();
    _token = await _localStorageService.getAuthToken();
    if (_token == null) throw NoAuthTokenFoundException();
    final result = await _restApiService.updateTodoStatus(
        id: id, token: _token!, isCompleted: isCompleted);
    return result;
  }

  Future<bool> deleteTodo(String id) async {
    _isConnected = await isConnectedToInternet();
    if (!_isConnected) throw NoInternetConnectionException();
    _token = await _localStorageService.getAuthToken();
    if (_token == null) throw NoAuthTokenFoundException();
    final result = await _restApiService.deleteTodo(id: id, token: _token!);
    return result;
  }
}
