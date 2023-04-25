import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/data/model/detail_package.dart';

import '../../data/repository/travel_package_repository.dart';
import '../../data/repository/user_repository.dart';

///Event
abstract class DetailEvent extends Equatable {
  const DetailEvent();
  @override
  List<Object?> get props => [];
}

class LoadPackageDetail extends DetailEvent {
  final String id;
  const LoadPackageDetail(this.id);
  @override
  List<Object?> get props => [];
}

class TogglePackageLike extends DetailEvent {
  final bool isLiked;
  final String packageId;
  const TogglePackageLike({required this.isLiked, required this.packageId});
  @override
  List<Object?> get props => [isLiked, packageId];
}

///State
abstract class DetailState extends Equatable {
  const DetailState();
  @override
  List<Object?> get props => [];
}

class DetailLoading extends DetailState {}

class DetailLoadSuccess extends DetailState {
  final bool isLiked;
  final DetailPackage package;
  // const DetailLoadSuccess(this.package);
  const DetailLoadSuccess({required this.package, required this.isLiked});
  @override
  List<Object?> get props => [package, isLiked];
}

class DetailLoadFailed extends DetailState {}

///Bloc
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final TravelPackageRepository _travelPackageRepository;
  DetailBloc(this._travelPackageRepository) : super(DetailLoading()) {
    on<LoadPackageDetail>(_onLoadDetailPackage);
    on<TogglePackageLike>(_onTogglePackageLike);
  }

  void _onLoadDetailPackage(
      LoadPackageDetail event, Emitter<DetailState> emit) async {
    final result = await _travelPackageRepository.fetchPackageDetail(event.id);
    final isLiked = await _travelPackageRepository.isPackageLiked(event.id);
    emit(DetailLoadSuccess(isLiked: isLiked, package: result));
  }

  void _onTogglePackageLike(
      TogglePackageLike event, Emitter<DetailState> emit) async {
    final currentState = state as DetailLoadSuccess;
    emit(DetailLoading());
    final isLiked = await _travelPackageRepository.toggleLikePackage(
        isLiked: event.isLiked, packageId: event.packageId);

    emit(DetailLoadSuccess(isLiked: isLiked, package: currentState.package));
  }
}
