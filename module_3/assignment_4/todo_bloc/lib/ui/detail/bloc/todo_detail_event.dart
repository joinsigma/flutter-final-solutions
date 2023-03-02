import 'package:equatable/equatable.dart';

///Event
abstract class TodoDetailEvent extends Equatable {
  const TodoDetailEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTodoStatus extends TodoDetailEvent {
  final String id;
  final bool isCompleted;
  const UpdateTodoStatus({required this.id, required this.isCompleted});
  @override
  List<Object?> get props => [id, isCompleted];
}

class DeleteTodo extends TodoDetailEvent {
  final String id;
  const DeleteTodo({required this.id});
  @override
  List<Object?> get props => [id];
}
