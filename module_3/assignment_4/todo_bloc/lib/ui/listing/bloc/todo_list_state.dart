import 'package:equatable/equatable.dart';

import '../../../data/model/todo.dart';

abstract class TodoListState extends Equatable {
  const TodoListState();
  @override
  List<Object?> get props => [];
}

class TodoListLoading extends TodoListState {}

class TodoListSuccess extends TodoListState {
  final List<Todo> todos;
  const TodoListSuccess(this.todos);
  @override
  List<Object?> get props => [todos];
}

class TodoListFailure extends TodoListState {
  final bool isApiError;
  final bool isSessionExpired;
  final bool isNetworkError;

  const TodoListFailure(
      {required this.isApiError,
      required this.isSessionExpired,
      required this.isNetworkError});
  @override
  List<Object?> get props => [isApiError, isSessionExpired, isNetworkError];
}

class LoggedOut extends TodoListState {}
