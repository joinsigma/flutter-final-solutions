import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/data/storage/exceptions.dart';
import 'package:flutter_todo_bloc/ui/listing/bloc/todo_list_event.dart';
import 'package:flutter_todo_bloc/ui/listing/bloc/todo_list_state.dart';

import '../../../data/network/exceptions.dart';
import '../../../data/repository/base_repository.dart';
import '../../../data/repository/exceptions.dart';
import '../../../data/repository/todo_repository.dart';
import '../../../data/repository/user_repository.dart';
import '../../../data/storage/local_storage_service.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final TodoRepository _todoRepository;
  final UserRepository _userRepository;
  TodoListBloc(
    this._todoRepository,
    this._userRepository,
  ) : super(TodoListLoading()) {
    on<LoadTodoList>(_onLoadTodoList);
    on<TriggerLogout>(_onTriggerLogout);
    on<ResetToken>(_onResetToken);
  }

  void _onResetToken(ResetToken event, Emitter<TodoListState> emit) async {
    _userRepository.deleteUserToken();
  }

  void _onLoadTodoList(LoadTodoList event, Emitter<TodoListState> emit) async {
    try {
      final todos = await _todoRepository.getMyTodos();
      emit(TodoListSuccess(todos));
    } on NoInternetConnectionException catch (_) {
      emit(const TodoListFailure(
          isSessionExpired: false, isApiError: false, isNetworkError: true));
    } on NoAuthTokenFoundException catch (_) {
      emit(const TodoListFailure(
          isSessionExpired: true, isApiError: false, isNetworkError: false));
    } on NotAuthorizedException catch (_) {
      emit(const TodoListFailure(
          isSessionExpired: true, isApiError: false, isNetworkError: false));
    } on GetAllTodosException catch (_) {
      emit(const TodoListFailure(
          isSessionExpired: false, isApiError: true, isNetworkError: false));
    }
  }

  void _onTriggerLogout(
      TriggerLogout event, Emitter<TodoListState> emit) async {
    emit(TodoListLoading());
    try {
      _userRepository.deleteUserId();
      _userRepository.deleteUserToken();
      emit(LoggedOut());
    } on AuthTokenException catch (_) {
      emit(const TodoListFailure(
          isSessionExpired: false, isApiError: true, isNetworkError: false));
    } on UidException catch (_) {
      emit(const TodoListFailure(
          isSessionExpired: false, isApiError: true, isNetworkError: false));
    }
  }
}
