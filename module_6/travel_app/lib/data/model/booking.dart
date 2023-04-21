import 'package:flutter/cupertino.dart';

enum BookingStatus { active, past, cancelled }

class Booking {
  final String id;
  final String userId;
  final String email;
  final String custFirstName;
  final String custLastName;
  final String mobileNo;
  final String billingAddress;
  final int numPax;
  final DateTime startDate;
  final DateTime endDate;
  final String packageId;
  final BookingStatus? status;
  final String? imageUrl;
  final int totalPrice;

  Booking(
      {required this.packageId,
      required this.id,
      required this.totalPrice,
      required this.userId,
      required this.email,
      required this.custFirstName,
      required this.custLastName,
      required this.mobileNo,
      required this.billingAddress,
      required this.numPax,
      required this.startDate,
      required this.endDate,
      this.imageUrl,
      this.status});
}
