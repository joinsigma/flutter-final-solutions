import 'package:equatable/equatable.dart';

/// Todo 11: Prepare bloc states for registration_bloc
///   - states: [RegistrationInitial], [RegistrationLoading], [RegistrationSuccessful], [RegistrationFailed]

abstract class RegistrationState extends Equatable {}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class RegistrationLoading extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class RegistrationSuccessful extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class RegistrationFailed extends RegistrationState {
  final String errorMsg;

  RegistrationFailed(this.errorMsg);

  @override  
  List<Object?> get props => [errorMsg];
}