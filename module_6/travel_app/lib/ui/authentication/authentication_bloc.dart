import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/user_repository.dart';
import 'package:equatable/equatable.dart';

///Event
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}


///State
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object?> get props => [];
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {}

class CheckUserStatus extends AuthenticationEvent {}

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