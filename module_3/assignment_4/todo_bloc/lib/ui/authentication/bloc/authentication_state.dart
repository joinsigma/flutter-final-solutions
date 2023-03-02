import 'package:equatable/equatable.dart';

///State
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object?> get props => [];
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {}