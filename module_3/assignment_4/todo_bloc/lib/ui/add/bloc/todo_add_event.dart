import 'package:equatable/equatable.dart';

import '../../../data/model/todo.dart';

abstract class TodoAddEvent extends Equatable {
  const TodoAddEvent();
  @override
  List<Object?> get props => [];
}

class AddNewTodo extends TodoAddEvent {
  final String title;
  final String description;
  final bool isCompleted;
  final Priority priority;
  final DateTime deadline;
  const AddNewTodo(
      {required this.title,
      required this.description,
      required this.isCompleted,
      required this.priority,
      required this.deadline});

  @override
  List<Object?> get props =>
      [title, description, isCompleted, priority, deadline];
}
