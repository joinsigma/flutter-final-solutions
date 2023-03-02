import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

///Bloc
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc(this._userRepository) : super(AuthenticationLoading()) {
    on<CheckUserStatus>(_onCheckUserStatus);
  }

  void _onCheckUserStatus(
      CheckUserStatus event, Emitter<AuthenticationState> emit) async {
    final isLoggedIn = await _userRepository.isUserLoggedIn();
    if (isLoggedIn) {
      emit(AuthenticationSuccess());
    } else {
      emit(AuthenticationFailure());
    }
  }
}
