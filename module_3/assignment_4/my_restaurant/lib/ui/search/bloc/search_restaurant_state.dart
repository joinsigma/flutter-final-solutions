import 'package:equatable/equatable.dart';
import 'package:my_restaurant/data/model/restaurant_summary.dart';

abstract class SearchRestaurantState extends Equatable {}

class SearchRestaurantInitial extends SearchRestaurantState {
  @override
  List<Object?> get props => [];
}

class SearchRestaurantLoading extends SearchRestaurantState {
  @override
  List<Object?> get props => [];
}

class SearchRestaurantSuccessful extends SearchRestaurantState {
  final List<RestaurantSummary> restaurants;

  SearchRestaurantSuccessful(this.restaurants);

  @override
  List<Object?> get props => [restaurants];
}

class SearchRestaurantFailed extends SearchRestaurantState {
  final String errorMsg;

  SearchRestaurantFailed(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
