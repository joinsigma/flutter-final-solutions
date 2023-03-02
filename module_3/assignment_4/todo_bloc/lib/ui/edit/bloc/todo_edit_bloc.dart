import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/edit/bloc/todo_edit_event.dart';
import 'package:flutter_todo_bloc/ui/edit/bloc/todo_edit_state.dart';

import '../../../data/model/todo.dart';
import '../../../data/network/exceptions.dart';
import '../../../data/repository/base_repository.dart';
import '../../../data/repository/exceptions.dart';
import '../../../data/repository/todo_repository.dart';

class TodoEditBloc extends Bloc<TodoEditEvent, TodoEditState> {
  final TodoRepository _todoRepository;
  TodoEditBloc(this._todoRepository) : super(TodoEditInitial()) {
    on<SaveTodo>(_onSaveTodo);
  }

  void _onSaveTodo(SaveTodo event, Emitter<TodoEditState> emit) async {
    try {
      Todo editedTodo = Todo(
          id: event.id,
          userId: event.userId,
          title: event.title,
          deadline: event.deadline,
          description: event.description,
          isCompleted: event.isCompleted,
          updatedAt: DateTime.now(),
          createdAt: event.createdAt,
          priority: event.priority);
      final result = await _todoRepository.editTodo(editedTodo);
      if (result) {
        emit(TodoEditSuccess());
      }
    } on NoInternetConnectionException catch (_) {
      emit(const TodoEditFailure(
          isSessionExpired: false, isApiError: false, isNetworkError: true));
    } on NoAuthTokenFoundException catch (_) {
      emit(const TodoEditFailure(
          isSessionExpired: true, isApiError: false, isNetworkError: false));
    } on NotAuthorizedException catch (_) {
      emit(const TodoEditFailure(
          isSessionExpired: true, isApiError: false, isNetworkError: false));
    } on UpdateTodoException catch (_) {
      emit(const TodoEditFailure(
          isSessionExpired: false, isApiError: true, isNetworkError: false));
    }
  }
}
