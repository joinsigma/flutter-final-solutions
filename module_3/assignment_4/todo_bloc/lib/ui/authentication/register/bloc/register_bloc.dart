import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/data/network/exceptions.dart';
import 'package:flutter_todo_bloc/data/storage/exceptions.dart';
import 'package:flutter_todo_bloc/ui/authentication/register/bloc/register_event.dart';
import 'package:flutter_todo_bloc/ui/authentication/register/bloc/register_state.dart';

import '../../../../data/repository/user_repository.dart';

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
    } on UserRegistrationError catch (_) {
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
