import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/data/model/detail_package.dart';

import '../../data/repository/travel_package_repository.dart';

///Event
abstract class BookingConfirmEvent extends Equatable {
  const BookingConfirmEvent();
  @override
  List<Object?> get props => [];
}

class LoadPackageDetail extends BookingConfirmEvent {
  final String id;
  const LoadPackageDetail(this.id);
  @override
  List<Object?> get props => [];
}

///State
abstract class BookingConfirmState extends Equatable {
  const BookingConfirmState();
  @override
  List<Object?> get props => [];
}

class BookingConfirmLoading extends BookingConfirmState {}

class BookingConfirmSuccess extends BookingConfirmState {
  final DetailPackage package;
  const BookingConfirmSuccess(this.package);
  @override
  List<Object?> get props => [package];
}

class BookingConfirmFailed extends BookingConfirmState {}

///Bloc
class BookingConfirmBloc extends Bloc<BookingConfirmEvent, BookingConfirmState> {
  final TravelPackageRepository _travelPackageRepository;
  BookingConfirmBloc(this._travelPackageRepository) : super(BookingConfirmLoading()) {
    on<LoadPackageDetail>(_onLoadDetailPackage);
  }

  void _onLoadDetailPackage(
      LoadPackageDetail event, Emitter<BookingConfirmState> emit) async {
    final result = await _travelPackageRepository.fetchPackageDetail(event.id);
    emit(BookingConfirmSuccess(result));
  }
}
