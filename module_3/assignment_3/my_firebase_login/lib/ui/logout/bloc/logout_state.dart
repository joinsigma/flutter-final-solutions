import 'package:equatable/equatable.dart';

/// Todo 17: Prepare logout states for logout_bloc
///   - states: [LogoutInitial], [LogoutLoading], [LogoutSuccessful], [LogoutFailed]

abstract class LogoutState extends Equatable {}

class LogoutInitial extends LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutLoading extends LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutSuccessful extends LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutFailed extends LogoutState {
  final String errorMsg;

  LogoutFailed(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
