import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/user_repository.dart';
import '../../../data/network/exceptions.dart';
import '../../../data/storage/exceptions.dart';

import 'package:equatable/equatable.dart';

///Events
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object?> get props => [];
}

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

class TriggerRegister extends RegisterEvent {
  final String email;
  final String password;

  const TriggerRegister({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

/// Bloc
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  RegisterBloc(this._userRepository) : super(RegisterInitial()) {
    on<TriggerRegister>(_onTriggerRegister);
  }

  void _onTriggerRegister(
      TriggerRegister event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      await _userRepository.registerUser(
          email: event.email, password: event.password);
      emit(RegisterSuccess());
    } on UserRegistrationException catch (_) {
      emit(
        const RegisterFailure(
            isApiError: true, isAuthTokenError: false, isUidError: false),
      );
    } on AuthTokenException catch (_) {
      emit(
        const RegisterFailure(
            isApiError: false, isAuthTokenError: true, isUidError: false),
      );
    } on UidException catch (_) {
      emit(
        const RegisterFailure(
            isApiError: false, isAuthTokenError: false, isUidError: true),
      );
    }
  }
}
