class RestaurantDetails {
  final String id;
  final String name;
  final String imageUrl;
  final bool isClosed;
  final String webpageUrl;
  final String displayPhone;
  final List<String> displayAddress;
  final double rating;
  final int reviewCount;

  RestaurantDetails({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.isClosed,
    required this.webpageUrl,
    required this.displayPhone,
    required this.reviewCount,
    required this.rating,
    required this.displayAddress,
  });

  RestaurantDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        imageUrl = json['image_url'] as String,
        isClosed = json['is_closed'] as bool,
        webpageUrl = json['url'] as String,
        displayPhone = json['display_phone'] as String,
        displayAddress = [...json['location']['display_address']],
        rating = (json['rating'] as num).toDouble(),
        reviewCount = json['review_count'] as int;
}
