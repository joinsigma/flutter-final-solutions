import 'package:equatable/equatable.dart';
import 'package:my_restaurant/data/model/restaurant_details.dart';

abstract class RestaurantDetailsState extends Equatable {}

class RestaurantDetailsInitial extends RestaurantDetailsState {
  @override
  List<Object?> get props => [];
}

class RestaurantDetailsLoading extends RestaurantDetailsState {
  @override
  List<Object?> get props => [];
}

class RestaurantDetailsSuccessful extends RestaurantDetailsState {
  final RestaurantDetails restaurantDetails;

  RestaurantDetailsSuccessful(this.restaurantDetails);

  @override
  List<Object?> get props => [restaurantDetails];
}

class RestaurantDetailsFailed extends RestaurantDetailsState {
  final String errorMsg;

  RestaurantDetailsFailed(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}