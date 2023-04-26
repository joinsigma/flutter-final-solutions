import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/data/repository/travel_package_repository.dart';

import '../../data/model/package.dart';

///Event
abstract class LikesEvent extends Equatable {
  const LikesEvent();
  @override
  List<Object?> get props => [];
}

class LoadLikes extends LikesEvent {}

class TriggerUnlike extends LikesEvent {
  final String packageId;
  const TriggerUnlike({required this.packageId});
  @override
  List<Object?> get props => [packageId];
}

///State
abstract class LikesState extends Equatable {
  const LikesState();
  @override
  List<Object?> get props => [];
}

class LikesLoading extends LikesState {}

class LikesLoadSuccess extends LikesState {
  final List<Package> packages;
  const LikesLoadSuccess(this.packages);
  @override
  List<Object?> get props => [packages];
}

class LikesLoadFailed extends LikesState {}

///Bloc
class LikesBloc extends Bloc<LikesEvent, LikesState> {
  final TravelPackageRepository _travelPackageRepository;

  LikesBloc(this._travelPackageRepository) : super(LikesLoading()) {
    on<LoadLikes>(_onLoadLikes);
    on<TriggerUnlike>(_onTriggerUnlike);
  }

  void _onLoadLikes(LoadLikes event, Emitter<LikesState> emit) async {
    ///Todo: Implement exceptions
    final result = await _travelPackageRepository.fetchLikedPackages();
    emit(LikesLoadSuccess(result));
  }

  void _onTriggerUnlike(TriggerUnlike event, Emitter<LikesState> emit) async {
    final currentState = state as LikesLoadSuccess;
    emit(LikesLoading());
    await _travelPackageRepository.unLikePackage(packageId: event.packageId);

    ///Remove unliked package from list and emit success state
    ///Avoid refreshing list via API call by managing it locally.
    final packages =
        currentState.packages.where((p) => p.id != event.packageId).toList();
    emit(LikesLoadSuccess(packages));
  }
}
