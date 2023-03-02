import 'package:equatable/equatable.dart';

abstract class TodoAddState extends Equatable {
  const TodoAddState();
  @override
  List<Object?> get props => [];
}

class TodoAddInitial extends TodoAddState {}

class TodoAddLoading extends TodoAddState {}

class TodoAddSuccess extends TodoAddState {}

class TodoAddFailure extends TodoAddState {
  final bool isApiError;
  final bool isSessionExpired;

  const TodoAddFailure({
    required this.isApiError,
    required this.isSessionExpired,
  });
  @override
  List<Object?> get props => [isApiError, isSessionExpired];
}
