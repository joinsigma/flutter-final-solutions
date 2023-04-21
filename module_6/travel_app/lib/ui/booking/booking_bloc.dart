import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/booking_detail.dart';
import '../../data/model/package.dart';
import '../../data/repository/booking_repository.dart';
import '../../data/repository/travel_package_repository.dart';

///Event
abstract class BookingEvent extends Equatable {
  const BookingEvent();
  @override
  List<Object?> get props => [];
}

class LoadBookings extends BookingEvent {}

///State
abstract class BookingState extends Equatable {
  const BookingState();
  @override
  List<Object?> get props => [];
}

class BookingLoading extends BookingState {}

class BookingLoadSuccess extends BookingState {
  final List<BookingDetail> bookings;
  const BookingLoadSuccess(this.bookings);
  @override
  List<Object?> get props => [bookings];
}

class BookingLoadFailed extends BookingState {}

///Bloc
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository _bookingRepository;
  BookingBloc(this._bookingRepository) : super(BookingLoading()) {
    on<LoadBookings>(_onLoadBookings);
  }

  void _onLoadBookings(LoadBookings event, Emitter<BookingState> emit) async {
    ///Todo: Implement exceptions
    final result = await _bookingRepository.fetchBookings();
    emit(BookingLoadSuccess(result));
  }
}
