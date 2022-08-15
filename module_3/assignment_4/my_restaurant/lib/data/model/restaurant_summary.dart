class RestaurantSummary {
  final String id;
  final String name;
  final String imageUrl;
  final int reviewCount;
  final double rating;

  RestaurantSummary({
    required this.id,
    required this.name,
    required this.reviewCount,
    required this.rating,
    required this.imageUrl,
  });

  RestaurantSummary.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        imageUrl = json['image_url'] as String,
        reviewCount = json['review_count'] as int,
        rating = (json['rating'] as num).toDouble();
}
