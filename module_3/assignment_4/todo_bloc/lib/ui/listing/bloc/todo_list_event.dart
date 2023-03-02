import 'package:equatable/equatable.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();
  @override
  List<Object?> get props => [];
}

class LoadTodoList extends TodoListEvent{}

class TriggerLogout extends TodoListEvent{}