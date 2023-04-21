import 'package:travel_app/data/network/firebase_api_service.dart';

import '../model/booking_detail.dart';

class BookingRepository {
  final FirebaseApiService _firebaseApiService;

  BookingRepository(this._firebaseApiService);

  Future<void> confirmBooking(BookingDetail booking, int totalPrice) async {
    await _firebaseApiService.createNewBooking(
        booking: booking,
        totalPrice: totalPrice);
  }

  Future<List<BookingDetail>> fetchBookings() async {
    final result = await _firebaseApiService.getBookings('1');
    return result;
  }
}
