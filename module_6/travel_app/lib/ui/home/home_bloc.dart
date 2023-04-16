import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/package.dart';
import '../../data/repository/travel_package_repository.dart';

///Event
abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class LoadPackages extends HomeEvent {}

///State
abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<Package> packages;
  const HomeLoadSuccess(this.packages);
  @override
  List<Object?> get props => [packages];
}

class HomeLoadFailed extends HomeState {}

///Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TravelPackageRepository _travelPackageRepository;
  HomeBloc(this._travelPackageRepository) : super(HomeLoading()) {
    on<LoadPackages>(_onLoadPackages);
  }

  void _onLoadPackages(LoadPackages event, Emitter<HomeState> emit) async {
    ///Todo: Implement exceptions
    final result = await _travelPackageRepository.fetchPackages();
    emit(HomeLoadSuccess(result));
  }
}
