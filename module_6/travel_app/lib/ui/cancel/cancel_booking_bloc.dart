import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/booking_detail.dart';
import '../../data/model/package.dart';
import '../../data/repository/booking_repository.dart';
import '../../data/repository/travel_package_repository.dart';

///Event
abstract class CancelBookingEvent extends Equatable {
  const CancelBookingEvent();
  @override
  List<Object?> get props => [];
}

class TriggerCancelBooking extends CancelBookingEvent {
  final String id;
  const TriggerCancelBooking({required this.id});
  @override
  List<Object?> get props => [id];
}

///State
abstract class CancelBookingState extends Equatable {
  const CancelBookingState();
  @override
  List<Object?> get props => [];
}

class CancelBookingInitial extends CancelBookingState {}

class CancelBookingLoading extends CancelBookingState {}

class CancelBookingSuccess extends CancelBookingState {}

class CancelBookingFailed extends CancelBookingState {}

///Bloc
class CancelBookingBloc extends Bloc<CancelBookingEvent, CancelBookingState> {
  final BookingRepository _bookingRepository;
  CancelBookingBloc(this._bookingRepository) : super(CancelBookingInitial()) {
    on<TriggerCancelBooking>(_onTriggerCancelBooking);
  }

  void _onTriggerCancelBooking(
      TriggerCancelBooking event, Emitter<CancelBookingState> emit) async {
    ///Todo: Implement exceptions
    emit(CancelBookingInitial());
    await _bookingRepository.cancelBooking(event.id);
    emit(CancelBookingSuccess());
  }
}
