import 'package:travel_app/data/network/firebase_api_service.dart';

import '../model/booking.dart';

class BookingRepository {
  final FirebaseApiService _firebaseApiService;

  BookingRepository(this._firebaseApiService);

  Future<void> confirmBooking(Booking booking) async {
    await _firebaseApiService.createNewBooking(booking);
  }

  Future<List<Booking>> fetchBookings() async {
    final result = await _firebaseApiService.getBookings('1');
    return result;
  }
}
