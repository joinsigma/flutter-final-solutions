import 'package:equatable/equatable.dart';

///State
abstract class TodoDetailState extends Equatable {
  const TodoDetailState();
  @override
  List<Object?> get props => [];
}

class TodoDetailInitial extends TodoDetailState {}

class TodoDetailLoading extends TodoDetailState {}

class TodoDetailSuccess extends TodoDetailState {}

class TodoDetailFailure extends TodoDetailState {
  final bool isApiError;
  final bool isSessionExpired;
  final bool isNetworkError;

  const TodoDetailFailure(
      {required this.isApiError,
      required this.isSessionExpired,
      required this.isNetworkError});
  @override
  List<Object?> get props => [isApiError, isSessionExpired, isNetworkError];
}
