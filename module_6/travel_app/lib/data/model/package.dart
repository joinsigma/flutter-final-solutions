class Package {
  final String id;
  final String title;
  final String location;
  final String imgUrl;
  final List<String> tags;
  final int price;

  Package(
      {
        required this.id,
        required this.title,
      required this.location,
      required this.imgUrl,
      required this.price,
      required this.tags});

  Package.fromJson(Map<String, dynamic> json)
      :
        id = json['id'],
        title = json['title'],
        location = json['location'],
        imgUrl = json['main_img_url'],
        price = json['price_per_pax'],
        tags = List<String>.from(json['tags']);
}
