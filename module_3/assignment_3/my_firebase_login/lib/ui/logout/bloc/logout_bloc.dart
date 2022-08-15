import 'package:bloc/bloc.dart';
import 'package:my_firebase_login/data/storage/local_storage_service.dart';
import 'package:my_firebase_login/ui/logout/bloc/logout_event.dart';
import 'package:my_firebase_login/ui/logout/bloc/logout_state.dart';

/// Todo 18: Construct logout_bloc with created event & states
///   event: [TriggerLogout]
///   states: [LogoutInitial], [LogoutLoading], [LogoutSuccessful], [LogoutFailed]

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LocalStorageService _localStorageService;

  // Constructor
  LogoutBloc(this._localStorageService) : super(LogoutInitial()) {
    on<TriggerLogout>(_onTriggerLogout);
  }

  // Handle TriggerLogout
  void _onTriggerLogout(
    TriggerLogout event,
    Emitter<LogoutState> emit,
  ) async {
    emit(LogoutLoading());
    final isLoggedOutSuccessful = await _localStorageService.deleteUserToken();
    if (isLoggedOutSuccessful) {
      emit(LogoutSuccessful());
    } else {
      emit(LogoutFailed('Error occured during logout process'));
    }
  }
}
