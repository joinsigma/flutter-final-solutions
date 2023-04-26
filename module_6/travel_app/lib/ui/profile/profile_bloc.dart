import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/data/model/detail_package.dart';

import '../../data/repository/travel_package_repository.dart';
import '../../data/repository/user_repository.dart';

///Event
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class LoadUserDetail extends ProfileEvent {
  final String id;
  const LoadUserDetail(this.id);
  @override
  List<Object?> get props => [];
}

class TriggerLogout extends ProfileEvent {}

///State
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final bool isLiked;
  final DetailPackage package;
  // const DetailLoadSuccess(this.package);
  const ProfileLoadSuccess({required this.package, required this.isLiked});
  @override
  List<Object?> get props => [package, isLiked];
}

class ProfileLoadFailed extends ProfileState {}

class LoggedOut extends ProfileState {}

///Bloc
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  ProfileBloc(this._userRepository) : super(ProfileLoading()) {
    on<LoadUserDetail>(_onLoadUserDetail);
    on<TriggerLogout>(_onTriggerLogout);
  }

  void _onLoadUserDetail(
      LoadUserDetail event, Emitter<ProfileState> emit) async {
    // final result = await _travelPackageRepository.fetchPackageDetail(event.id);
    // final isLiked = await _travelPackageRepository.isPackageLiked(event.id);
    // emit(ProfileLoadSuccess(isLiked: isLiked, package: result));
  }

  void _onTriggerLogout(TriggerLogout event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    _userRepository.deleteUserId();
    emit(LoggedOut());
  }
}
