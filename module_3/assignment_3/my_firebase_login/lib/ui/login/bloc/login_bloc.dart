import 'package:bloc/bloc.dart';
import 'package:my_firebase_login/data/network/exceptions.dart';
import 'package:my_firebase_login/data/repository/user_repository.dart';
import 'package:my_firebase_login/ui/login/bloc/login_event.dart';
import 'package:my_firebase_login/ui/login/bloc/login_state.dart';

/// Todo 15: Construct login_bloc with event & states defined
///   - event: [TriggerLogin], [ValidateUserStatus]
///   - states: [LoginInitial], [LoginLoading], [LoginSuccessful], [LoginFailed], [LoginNotRequired]
///

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  // Constructor
  LoginBloc(this._userRepository) : super(LoginInitial()) {
    on<TriggerLogin>(_onTriggerLogin);
    on<ValidateUserStatus>(_onValidateUserStatus);
  }

  // Handle TriggerLogin
  void _onTriggerLogin(
    TriggerLogin event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      await _userRepository.loginExistingUser(
        event.email,
        event.password,
      );
      emit(LoginSuccessful());
    } on UserLoginError catch (exception) {
      emit(LoginFailed(exception.errorMsg));
    } catch (exception) {
      emit(LoginFailed(exception.toString()));
    }
  }

  // Handle ValidateUserStatus
  void _onValidateUserStatus(
    ValidateUserStatus event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final isLoggedIn = await _userRepository.isUserLoggedIn();
    if (isLoggedIn) {
      emit(LoginNotRequired());
    } else {
      emit(LoginInitial());
    }
  }
}
