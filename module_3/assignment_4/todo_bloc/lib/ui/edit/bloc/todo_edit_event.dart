import 'package:equatable/equatable.dart';

import '../../../data/model/todo.dart';

///Event
abstract class TodoEditEvent extends Equatable {
  const TodoEditEvent();
  @override
  List<Object?> get props => [];
}

class SaveTodo extends TodoEditEvent {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime deadline;
  final Priority priority;
  final bool isCompleted;
  const SaveTodo({
    required this.description,
    required this.id,
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.priority,
    required this.isCompleted,
    required this.deadline,
  });
  @override
  List<Object?> get props => [id, isCompleted];
}
