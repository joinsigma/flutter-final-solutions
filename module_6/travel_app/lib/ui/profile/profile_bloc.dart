import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/data/model/user.dart';
import 'dart:io';
import '../../data/repository/user_repository.dart';

///Event
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class LoadUserDetail extends ProfileEvent {}

class NewProfileImageSelected extends ProfileEvent {
  final File newProfileImage;
  const NewProfileImageSelected({required this.newProfileImage});
  @override
  List<Object?> get props => [newProfileImage];
}

class SaveNewImage extends ProfileEvent {}

class CancelNewImage extends ProfileEvent {}

class TriggerLogout extends ProfileEvent {}

///State
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final File? selectedProfileImage;
  final bool isSaveProfileImgActive;
  final UserDetail userDetail;
  const ProfileLoadSuccess(
      {required this.userDetail,
      required this.isSaveProfileImgActive,
      this.selectedProfileImage});
  @override
  List<Object?> get props => [userDetail];
}

class ProfileLoadFailed extends ProfileState {}

class LoggedOut extends ProfileState {}

///Bloc
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  ProfileBloc(this._userRepository) : super(ProfileLoading()) {
    on<LoadUserDetail>(_onLoadUserDetail);
    on<TriggerLogout>(_onTriggerLogout);
    on<NewProfileImageSelected>(_onNewProfileImageSelected);
    on<SaveNewImage>(_onSaveNewImage);
    on<CancelNewImage>(_onCancelNewImage);
  }

  void _onLoadUserDetail(
      LoadUserDetail event, Emitter<ProfileState> emit) async {
    final result = await _userRepository.fetchUserDetail();
    emit(ProfileLoadSuccess(userDetail: result, isSaveProfileImgActive: false));
  }

  void _onTriggerLogout(TriggerLogout event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    _userRepository.deleteUserId();
    emit(LoggedOut());
  }

  void _onNewProfileImageSelected(
      NewProfileImageSelected event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _userRepository.fetchUserDetail();
    emit(ProfileLoadSuccess(
        userDetail: result,
        isSaveProfileImgActive: true,
        selectedProfileImage: event.newProfileImage));
  }

  void _onCancelNewImage(
      CancelNewImage event, Emitter<ProfileState> emit) async {
    final currentState = state as ProfileLoadSuccess;
    emit(ProfileLoading());
    emit(ProfileLoadSuccess(
        userDetail: currentState.userDetail,
        isSaveProfileImgActive: false,
        selectedProfileImage: null));
  }

  void _onSaveNewImage(SaveNewImage event, Emitter<ProfileState> emit) async {
    final currentState = state as ProfileLoadSuccess;
    emit(ProfileLoading());
    await _userRepository
        .saveNewProfileImage(currentState.selectedProfileImage!);
    add(LoadUserDetail());
    emit(ProfileLoadSuccess(
        userDetail: currentState.userDetail,
        isSaveProfileImgActive: false,
        selectedProfileImage: null));
  }
}
