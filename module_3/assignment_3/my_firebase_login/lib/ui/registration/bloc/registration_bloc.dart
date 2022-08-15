import 'package:bloc/bloc.dart';
import 'package:my_firebase_login/data/network/exceptions.dart';
import 'package:my_firebase_login/data/repository/user_repository.dart';
import 'package:my_firebase_login/ui/registration/bloc/registration_event.dart';
import 'package:my_firebase_login/ui/registration/bloc/registration_state.dart';

/// Todo 12: Construct registration_bloc with events & states defined
///   - event: [TriggerRegistration]
///   - states: [RegistrationInitial], [RegistrationLoading], [RegistrationSuccessful], [RegistrationFailed]

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final UserRepository _userRepository;

  // Constructor
  RegistrationBloc(this._userRepository) : super(RegistrationInitial()) {
    on<TriggerRegistration>(_onTriggerRegistration);
  }

  // Helper function to handle TriggerRegistration
  void _onTriggerRegistration(
    TriggerRegistration event,
    Emitter<RegistrationState> emit,
  ) async {
    try {
      emit(RegistrationLoading());
      await _userRepository.registerUser(
        event.email,
        event.password,
      );
      emit(RegistrationSuccessful());
    } on UserRegistrationError catch (exception) {
      emit(RegistrationFailed(exception.errorMsg));
    }
  }
}
