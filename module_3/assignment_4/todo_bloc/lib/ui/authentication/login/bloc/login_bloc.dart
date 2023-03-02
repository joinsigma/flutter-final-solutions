import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/data/repository/exceptions.dart';
import 'package:flutter_todo_bloc/data/storage/exceptions.dart';

import '../../../../data/network/exceptions.dart';
import '../../../../data/repository/user_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

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
