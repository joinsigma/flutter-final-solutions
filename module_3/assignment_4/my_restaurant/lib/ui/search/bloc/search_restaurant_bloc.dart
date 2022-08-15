import 'package:bloc/bloc.dart';
import 'package:my_restaurant/data/network/exceptions.dart';
import 'package:my_restaurant/data/network/rest_api_service.dart';
import 'package:my_restaurant/data/repository/restaurant_repository.dart';
import 'package:my_restaurant/ui/search/bloc/search_restaurant_event.dart';
import 'package:my_restaurant/ui/search/bloc/search_restaurant_state.dart';

class SearchRestaurantBloc
    extends Bloc<SearchRestaurantEvent, SearchRestaurantState> {
  final RestaurantRepository _restaurantRepository;

// Constructor - initial state: SeachInitial
  SearchRestaurantBloc(this._restaurantRepository)
      : super(SearchRestaurantInitial()) {
    on<TriggerSearch>(_onTriggerSearch);
  }

  // Handle TriggerSearch
  void _onTriggerSearch(
    TriggerSearch event,
    Emitter<SearchRestaurantState> emit,
  ) async {
    try {
      emit(SearchRestaurantLoading());
      final restaurants = await _restaurantRepository.searchRestaurantByKeyword(
        event.location,
        event.keyword,
      );
      emit(SearchRestaurantSuccessful(restaurants));
    } on SearchRestaurantException catch (exception) {
      emit(SearchRestaurantFailed(exception.errorMsg));
    }
  }
}
