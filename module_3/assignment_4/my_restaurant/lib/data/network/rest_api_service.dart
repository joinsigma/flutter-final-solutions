import 'dart:convert';

import 'package:my_restaurant/data/model/restaurant_details.dart';
import 'package:my_restaurant/data/model/restaurant_summary.dart';
import 'package:http/http.dart' as http;
import 'package:my_restaurant/data/model/review.dart';
import 'package:my_restaurant/data/network/exceptions.dart';

class RestApiService {
  static const String baseUrl = 'https://api.yelp.com/v3';
  static const String apiToken =
      'dy3-eyS6J-GMtjkU7l3Ll_1nsyZ99wY9HTs4z4a_blyAGM-jZnxVQoRY-RUTK51GfX2L2jOasfCarbmIzB-lTWmlnDECgGMrFsFplbA_hbHzM1UifNqAmpYNldDvYnYx';
  static const headers = {'Authorization': 'Bearer $apiToken'};

  // API call to search restaurant
  Future<List<RestaurantSummary>> searchRestaurantByKeyword(
    String location,
    String keyword,
  ) async {
    final url = '$baseUrl/businesses/search?term=$keyword&location=$location';
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final raw = jsonDecode(response.body)['businesses'];
      final List<RestaurantSummary> restaurants = raw
          .map<RestaurantSummary>(
              (restaurant) => RestaurantSummary.fromJson(restaurant))
          .toList();
      return restaurants;
    } else {
      throw SearchRestaurantException(
          'API Error during search restaurant with parameters: term=$keyword | location=$location');
    }
  }

  // API call to get restaurant details
  Future<RestaurantDetails> getRestaurantDetailsById(
    String restaurantId,
  ) async {
    final url = '$baseUrl/businesses/$restaurantId';
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final raw = jsonDecode(response.body);
      return RestaurantDetails.fromJson(raw);
    } else {
      throw GetRestaurantDetailsException(
          'API Error during get restaurant details with parameters: restaurantId=$restaurantId');
    }
  }

  // API call to get restaurant reviews
  Future<List<Review>> getRestaurantReviewById(
    String restaurantId,
  ) async {
    final url = '$baseUrl/businesses/$restaurantId/reviews';
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final raw = jsonDecode(response.body)['reviews'];
      final List<Review> reviews =
          raw.map<Review>((review) => Review.fromJson(review)).toList();
      return reviews;
    } else {
      throw GetRestaurantReviewException(
        'API Error during get restaurant reviews with parameter: restaurantId=$restaurantId}',
      );
    }
  }
}
