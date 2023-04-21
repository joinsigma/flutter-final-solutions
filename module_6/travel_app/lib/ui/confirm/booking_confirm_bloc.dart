import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/data/model/detail_package.dart';
import 'package:travel_app/data/repository/booking_repository.dart';

import '../../data/model/booking.dart';
import '../../data/repository/travel_package_repository.dart';

///Event
abstract class BookingConfirmEvent extends Equatable {
  const BookingConfirmEvent();
  @override
  List<Object?> get props => [];
}

class TriggerBooking extends BookingConfirmEvent {
  final String fName;
  final String lName;
  final String email;
  final String mobileNo;
  final String billingAddress;
  final int numPax;
  final DateTime startDate;
  final DateTime endDate;
  final String packageId;
  final int totalPrice;
  const TriggerBooking({
    required this.packageId,
    required this.fName,
    required this.lName,
    required this.email,
    required this.mobileNo,
    required this.billingAddress,
    required this.numPax,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
  });
  @override
  List<Object?> get props => [
        fName,
        lName,
        email,
        mobileNo,
        billingAddress,
        numPax,
        startDate,
        endDate,
        totalPrice
      ];
}

///State
abstract class BookingConfirmState extends Equatable {
  const BookingConfirmState();
  @override
  List<Object?> get props => [];
}

class BookingConfirmInitial extends BookingConfirmState {}

class BookingConfirmLoading extends BookingConfirmState {}

class BookingConfirmSuccess extends BookingConfirmState {}

class BookingConfirmFailed extends BookingConfirmState {}

///Bloc
class BookingConfirmBloc
    extends Bloc<BookingConfirmEvent, BookingConfirmState> {
  final BookingRepository _bookingRepository;
  BookingConfirmBloc(this._bookingRepository) : super(BookingConfirmInitial()) {
    on<TriggerBooking>(_onTriggerBooking);
  }

  void _onTriggerBooking(
      TriggerBooking event, Emitter<BookingConfirmState> emit) async {
    emit(BookingConfirmLoading());
    final booking = Booking(
        id: '1',
        userId: '1',
        packageId: event.packageId,
        email: event.email,
        billingAddress: event.billingAddress,
        custFirstName: event.fName,
        custLastName: event.lName,
        mobileNo: event.mobileNo,
        numPax: event.numPax,
        startDate: event.startDate,
        endDate: event.endDate,
        totalPrice: event.totalPrice);
    await _bookingRepository.confirmBooking(booking);
    emit(BookingConfirmSuccess());
  }
}
