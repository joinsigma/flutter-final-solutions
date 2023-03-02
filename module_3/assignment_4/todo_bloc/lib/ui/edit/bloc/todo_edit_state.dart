import 'package:equatable/equatable.dart';

///State
abstract class TodoEditState extends Equatable {
  const TodoEditState();
  @override
  List<Object?> get props => [];
}

class TodoEditInitial extends TodoEditState {}

class TodoEditLoading extends TodoEditState {}

class TodoEditSuccess extends TodoEditState {}

class TodoEditFailure extends TodoEditState {
  final bool isApiError;
  final bool isSessionExpired;
  final bool isNetworkError;

  const TodoEditFailure(
      {required this.isApiError,
      required this.isSessionExpired,
      required this.isNetworkError});
  @override
  List<Object?> get props => [isApiError, isSessionExpired, isNetworkError];
}
