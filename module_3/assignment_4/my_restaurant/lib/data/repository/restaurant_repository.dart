import 'package:my_restaurant/data/model/restaurant_details.dart';
import 'package:my_restaurant/data/model/restaurant_summary.dart';
import 'package:my_restaurant/data/model/review.dart';
import 'package:my_restaurant/data/network/rest_api_service.dart';

class RestaurantRepository {
  final RestApiService _restApiService;
  RestaurantRepository(this._restApiService);

  // Handle SearchRestaurantByKeyword
  Future<List<RestaurantSummary>> searchRestaurantByKeyword(
    String location,
    String keyword,
  ) async {
    final restaurants = await _restApiService.searchRestaurantByKeyword(
      location,
      keyword,
    );
    return restaurants;
  }

  // Handle GetRestaurantDetailsById
  Future<RestaurantDetails> getRestaurantDetailsById(
    String restaurantId,
  ) async {
    final restaurantDetails =
        await _restApiService.getRestaurantDetailsById(restaurantId);
    return restaurantDetails;
  }

  // Handle GetRestaurantReview
  Future<List<Review>> getRestaurantReviewById(
    String restaurantId,
  ) async {
    final reviews = await _restApiService.getRestaurantReviewById(restaurantId);
    return reviews;
  }
}
