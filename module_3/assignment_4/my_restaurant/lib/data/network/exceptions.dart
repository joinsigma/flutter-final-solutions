class SearchRestaurantException implements Exception {
  final String errorMsg;
  SearchRestaurantException(this.errorMsg);
}

class GetRestaurantDetailsException implements Exception {
  final String errorMsg;
  GetRestaurantDetailsException(this.errorMsg);
}

class GetRestaurantReviewException implements Exception {
  final String errorMsg;
  GetRestaurantReviewException(this.errorMsg);
}