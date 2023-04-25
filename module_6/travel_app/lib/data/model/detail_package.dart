class DetailPackage {
  final String id;
  final String title;
  final String partnerName;
  final List<String> imgUrls;
  final List<String> tags;
  final List<Itinerary> itineraries;
  final double rating;
  final String location;
  final int price;
  final String description;
  final String mealInfo;

  DetailPackage(
      {required this.id,
      required this.mealInfo,
      required this.description,
      required this.itineraries,
      required this.location,
      required this.title,
      required this.price,
      required this.tags,
      required this.rating,
      required this.imgUrls,
      required this.partnerName});
}

class Itinerary {
  final String title;
  final String description;

  Itinerary({required this.title, required this.description});
}
