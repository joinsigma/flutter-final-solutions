import 'package:my_restaurant/data/model/review_user.dart';

class Review {
  final String id;
  final String text;
  final double rating;
  final DateTime createdTime;
  final ReviewUser createdUser;

  Review({
    required this.id,
    required this.text,
    required this.rating,
    required this.createdTime,
    required this.createdUser,
  });

  Review.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        text = json['text'] as String,
        rating = (json['rating'] as num).toDouble(),
        createdTime = DateTime.parse(json['time_created']),
        createdUser = ReviewUser.fromJson(json['user']);
}
