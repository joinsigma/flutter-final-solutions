enum BookingStatus { active, cancelled }

class BookingDetail {
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
  final String packageTitle;
  final String partnerName;
  final BookingStatus? status;
  final String? imageUrl;
  final int totalPrice;
  final DateTime createdAt;

  BookingDetail(
      {required this.packageId,
      required this.id,
      required this.userId,
      required this.packageTitle,
      required this.email,
      required this.custFirstName,
      required this.custLastName,
      required this.partnerName,
      required this.mobileNo,
      required this.billingAddress,
      required this.numPax,
      required this.startDate,
      required this.endDate,
      required this.createdAt,
      required this.totalPrice,
      this.imageUrl,
      this.status});
}
