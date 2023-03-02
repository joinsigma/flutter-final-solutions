import 'package:equatable/equatable.dart';

///States
abstract class RegisterState extends Equatable {
  const RegisterState();
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final bool isApiError;
  final bool isAuthTokenError;
  final bool isUidError;
  const RegisterFailure(
      {required this.isApiError,
        required this.isAuthTokenError,
        required this.isUidError});
  @override
  List<Object?> get props => [isApiError, isAuthTokenError, isUidError];
}