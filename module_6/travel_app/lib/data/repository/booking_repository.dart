import 'package:travel_app/data/network/firebase_api_service.dart';

import '../model/booking_detail.dart';
import '../storage/local_storage_service.dart';

class BookingRepository {
  final FirebaseApiService _firebaseApiService;
  final LocalStorageService _localStorageService;

  BookingRepository(this._firebaseApiService,this._localStorageService);

  Future<void> confirmBooking(BookingDetail booking, int totalPrice) async {
    final uid = await _localStorageService.getUserId();
    await _firebaseApiService.createNewBooking(
        booking: booking, totalPrice: totalPrice,uid : uid);
  }

  Future<List<BookingDetail>> fetchBookings() async {
    final result = await _firebaseApiService.getBookings('1');
    return result;
  }

  Future<void> cancelBooking(String bookingId) async {
    await _firebaseApiService.cancelBooking(bookingId);
  }
}
