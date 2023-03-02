import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/data/network/exceptions.dart';
import 'package:flutter_todo_bloc/data/repository/base_repository.dart';
import 'package:flutter_todo_bloc/data/repository/exceptions.dart';
import 'package:flutter_todo_bloc/data/repository/todo_repository.dart';
import 'package:flutter_todo_bloc/ui/detail/bloc/todo_detail_event.dart';
import 'package:flutter_todo_bloc/ui/detail/bloc/todo_detail_state.dart';
import '../../../data/repository/user_repository.dart';

///Bloc
class TodoDetailBloc extends Bloc<TodoDetailEvent, TodoDetailState> {
  final TodoRepository _todoRepository;
  TodoDetailBloc(this._todoRepository) : super(TodoDetailInitial()) {
    on<UpdateTodoStatus>(_onUpdateTodoStatus);
    on<DeleteTodo>(_onDeleteTodo);
  }

  void _onUpdateTodoStatus(
      UpdateTodoStatus event, Emitter<TodoDetailState> emit) async {
    try {
      final result = await _todoRepository.updateTodoStatus(
          id: event.id, isCompleted: event.isCompleted);
      if (result) {
        emit(TodoDetailSuccess());
      }
    } on NoInternetConnectionException catch (_) {
      emit(const TodoDetailFailure(
          isSessionExpired: false, isApiError: false, isNetworkError: true));
    } on NoAuthTokenFoundException catch (_) {
      emit(const TodoDetailFailure(
          isSessionExpired: true, isApiError: false, isNetworkError: false));
    } on NotAuthorizedException catch (_) {
      emit(const TodoDetailFailure(
          isSessionExpired: true, isApiError: false, isNetworkError: false));
    } on UpdateTodoException catch (_) {
      emit(const TodoDetailFailure(
          isSessionExpired: false, isApiError: true, isNetworkError: false));
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoDetailState> emit) async {
    try {
      final result = await _todoRepository.deleteTodo(event.id);
      if (result) {
        emit(TodoDetailSuccess());
      }
    } on NoInternetConnectionException catch (_) {
      emit(const TodoDetailFailure(
          isSessionExpired: false, isApiError: false, isNetworkError: true));
    } on NoAuthTokenFoundException catch (_) {
      emit(const TodoDetailFailure(
          isSessionExpired: true, isApiError: false, isNetworkError: false));
    } on NotAuthorizedException catch (_) {
      emit(const TodoDetailFailure(
          isSessionExpired: true, isApiError: false, isNetworkError: false));
    } on DeleteTodoException catch (_) {
      emit(const TodoDetailFailure(
          isSessionExpired: false, isApiError: true, isNetworkError: false));
    }
  }
}
