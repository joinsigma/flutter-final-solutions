import 'package:equatable/equatable.dart';

abstract class RestaurantDetailsEvent extends Equatable {}

class TriggerGetRestaurantDetails extends RestaurantDetailsEvent {
  final String restaurantId;

  TriggerGetRestaurantDetails(this.restaurantId);

  @override
  List<Object?> get props => [restaurantId];
}