class UserDetail {
  final String uid;
  final String name;
  final String email;
  final String address;
  final String mobileNum;
  final String imageUrl;
  final int numLikes;
  final int numTrips;

  UserDetail(
      {required this.uid,
      required this.name,
      required this.email,
      required this.address,
      required this.mobileNum,
      required this.imageUrl,
      required this.numTrips,
      required this.numLikes});
}
