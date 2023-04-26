import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/user_repository.dart';
import '../../../data/network/exceptions.dart';
import '../../../data/storage/exceptions.dart';
///Events
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}



///States
abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final bool isApiError;
  final bool isAuthTokenError;
  final bool isUidError;
  const LoginFailure(
      {required this.isApiError,
        required this.isAuthTokenError,
        required this.isUidError});
  @override
  List<Object?> get props => [isApiError, isAuthTokenError, isUidError];
}

class TriggerLogin extends LoginEvent {
  final String email;
  final String password;

  const TriggerLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  LoginBloc(this._userRepository) : super(LoginInitial()) {
    on<TriggerLogin>(_onTriggerLogin);
  }

  void _onTriggerLogin(TriggerLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await _userRepository.loginUser(
          email: event.email, password: event.password);
      emit(LoginSuccess());
    } on UserLoginException catch (_) {
      emit(
        const LoginFailure(
            isApiError: true, isAuthTokenError: false, isUidError: false),
      );
    } on AuthTokenException catch (_) {
      emit(
        const LoginFailure(
            isApiError: false, isAuthTokenError: true, isUidError: false),
      );
    } on UidException catch (_) {
      emit(
        const LoginFailure(
            isApiError: false, isAuthTokenError: false, isUidError: true),
      );
    }
  }
}