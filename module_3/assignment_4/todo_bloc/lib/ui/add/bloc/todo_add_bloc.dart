import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/data/network/exceptions.dart';
import 'package:flutter_todo_bloc/ui/add/bloc/todo_add_event.dart';
import 'package:flutter_todo_bloc/ui/add/bloc/todo_add_state.dart';

import '../../../data/model/todo.dart';
import '../../../data/repository/todo_repository.dart';
import '../../../data/repository/user_repository.dart';

class TodoAddBloc extends Bloc<TodoAddEvent, TodoAddState> {
  final TodoRepository _todoRepository;
  final UserRepository _userRepository;
  TodoAddBloc(this._userRepository, this._todoRepository)
      : super(TodoAddInitial()) {
    on<AddNewTodo>(_onAddNewTodo);
  }

  void _onAddNewTodo(AddNewTodo event, Emitter<TodoAddState> emit) async {
    emit(TodoAddLoading());
    try {
      ///Get userId
      final uid = await _userRepository.getUserId();
      Todo newTodo = Todo(
          id: '1',
          userId: uid,
          title: event.title,
          description: event.description,
          deadline: event.deadline,
          priority: event.priority,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isCompleted: false);
      final result = await _todoRepository.addNewTodo(newTodo);
      if (result) {
        emit(TodoAddSuccess());
      }
    } on NotAuthorizedException catch (_) {
      emit(
        const TodoAddFailure(isApiError: false, isSessionExpired: true),
      );
    } on AddTodoException catch (_) {
      emit(const TodoAddFailure(isApiError: true, isSessionExpired: false));
    }
  }
}
