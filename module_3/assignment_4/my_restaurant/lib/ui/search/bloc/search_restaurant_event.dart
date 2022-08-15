import 'package:equatable/equatable.dart';

abstract class SearchRestaurantEvent extends Equatable {}

class TriggerSearch extends SearchRestaurantEvent {
  final String location;
  final String keyword;

  TriggerSearch(this.location, this.keyword);

  @override
  List<Object?> get props => [location, keyword];
}
