import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/data/model/detail_package.dart';
import 'package:travel_app/data/repository/user_repository.dart';

import '../../data/repository/travel_package_repository.dart';

///Event
abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
  @override
  List<Object?> get props => [];
}

class SaveProfileDetail extends EditProfileEvent {
  final String name;
  final String email;
  final String mobileNum;
  final String address;
  const SaveProfileDetail(
      {required this.name,
      required this.email,
      required this.mobileNum,
      required this.address});
  @override
  List<Object?> get props => [name, email, mobileNum, address];
}

///State
abstract class EditProfileState extends Equatable {
  const EditProfileState();
  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}
class EditProfileLoading extends EditProfileState {}

class EditProfileLoadSuccess extends EditProfileState {}

class EditProfileLoadFailed extends EditProfileState {}

///Bloc
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserRepository _userRepository;
  EditProfileBloc(this._userRepository) : super(EditProfileInitial()) {
    on<SaveProfileDetail>(_onSaveProfileDetail);
  }

  void _onSaveProfileDetail(
      SaveProfileDetail event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    _userRepository.updateUserProfile(
        name: event.name,
        address: event.address,
        mobileNum: event.mobileNum,
        email: event.email);
    emit(EditProfileLoadSuccess());
  }
}
