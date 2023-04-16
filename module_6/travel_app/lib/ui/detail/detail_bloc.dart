import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/data/model/detail_package.dart';

import '../../data/repository/travel_package_repository.dart';

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

///State
abstract class DetailState extends Equatable {
  const DetailState();
  @override
  List<Object?> get props => [];
}

class DetailLoading extends DetailState {}

class DetailLoadSuccess extends DetailState {
  final DetailPackage package;
  const DetailLoadSuccess(this.package);
  @override
  List<Object?> get props => [package];
}

class DetailLoadFailed extends DetailState {}

///Bloc
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final TravelPackageRepository _travelPackageRepository;
  DetailBloc(this._travelPackageRepository) : super(DetailLoading()) {
    on<LoadPackageDetail>(_onLoadDetailPackage);
  }

  void _onLoadDetailPackage(
      LoadPackageDetail event, Emitter<DetailState> emit) async {
    final result = await _travelPackageRepository.fetchPackageDetail(event.id);
    emit(DetailLoadSuccess(result));
  }
}
