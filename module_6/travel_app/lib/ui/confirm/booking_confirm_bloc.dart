import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/data/model/detail_package.dart';
import 'package:travel_app/data/repository/booking_repository.dart';

import '../../data/model/booking_detail.dart';
import '../../data/repository/travel_package_repository.dart';

///Event
abstract class BookingConfirmEvent extends Equatable {
  const BookingConfirmEvent();
  @override
  List<Object?> get props => [];
}

class LoadPackageInfo extends BookingConfirmEvent {
  final String id;
  const LoadPackageInfo(this.id);
  @override
  List<Object?> get props => [id];
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
  final String imageUrl;
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
    required this.imageUrl,
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
        totalPrice,
        imageUrl
      ];
}

///State
abstract class BookingConfirmState extends Equatable {
  const BookingConfirmState();
  @override
  List<Object?> get props => [];
}

class BookingConfirmInitial extends BookingConfirmState {
  final String packageTitle;
  final String packageProvider;
  final String packageLocation;
  final double packageRating;
  final String imageUrl;
  final int packagePrice;

  const BookingConfirmInitial(
      {required this.packageTitle,
      required this.packageProvider,
      required this.packageLocation,
      required this.packageRating,
      required this.packagePrice,
      required this.imageUrl});
  @override
  List<Object?> get props => [
        packageTitle,
        packageProvider,
        packageLocation,
        packageRating,
        imageUrl,
        packagePrice
      ];
}

class BookingConfirmLoading extends BookingConfirmState {}

class BookingConfirmSuccess extends BookingConfirmState {}

class BookingConfirmFailed extends BookingConfirmState {}

///Bloc
class BookingConfirmBloc
    extends Bloc<BookingConfirmEvent, BookingConfirmState> {
  final BookingRepository _bookingRepository;
  final TravelPackageRepository _travelPackageRepository;
  BookingConfirmBloc(this._bookingRepository, this._travelPackageRepository)
      : super(BookingConfirmLoading()) {
    on<TriggerBooking>(_onTriggerBooking);
    on<LoadPackageInfo>(_onLoadPackageInfo);
  }

  void _onLoadPackageInfo(
      LoadPackageInfo event, Emitter<BookingConfirmState> emit) async {
    final result = await _travelPackageRepository.fetchPackageDetail(event.id);
    emit(BookingConfirmInitial(
      packagePrice: result.price,
      packageTitle: result.title,
      packageProvider: result.provider,
      packageLocation: result.location,
      packageRating: result.rating,
      imageUrl: result.imgUrls[0],
    ));
  }

  void _onTriggerBooking(
      TriggerBooking event, Emitter<BookingConfirmState> emit) async {
    emit(BookingConfirmLoading());
    final booking = BookingDetail(
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
        imageUrl: event.imageUrl,
        endDate: event.endDate,
        totalPrice: event.totalPrice,
        createdAt: DateTime.now());
    await _bookingRepository.confirmBooking(booking, event.totalPrice);
    emit(BookingConfirmSuccess());
  }
}
