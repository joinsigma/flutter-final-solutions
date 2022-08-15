import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {}

class TriggerGetReview extends ReviewEvent {
  final String restaurantId;

  TriggerGetReview(this.restaurantId);

  @override
  List<Object?> get props => [restaurantId];
}