
import 'package:equatable/equatable.dart';

///Event
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

class CheckUserStatus extends AuthenticationEvent {}