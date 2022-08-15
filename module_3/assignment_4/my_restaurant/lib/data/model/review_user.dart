class ReviewUser {
  final String id;
  final String? profileUrl;
  final String? imageUrl;
  final String? name;

  ReviewUser({
    required this.id,
    required this.profileUrl,
    required this.imageUrl,
    required this.name,
  });

  ReviewUser.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        profileUrl = json['profile_url'] as String,
        imageUrl = json['image_url'] as String?,
        name = json['name'] as String;
}
