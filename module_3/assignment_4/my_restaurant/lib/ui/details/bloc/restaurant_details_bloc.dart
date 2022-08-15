import 'package:bloc/bloc.dart';
import 'package:my_restaurant/data/network/exceptions.dart';
import 'package:my_restaurant/data/repository/restaurant_repository.dart';
import 'package:my_restaurant/ui/details/bloc/restaurant_details_event.dart';
import 'package:my_restaurant/ui/details/bloc/restaurant_details_state.dart';

class RestaurantDetailsBloc
    extends Bloc<RestaurantDetailsEvent, RestaurantDetailsState> {
  final RestaurantRepository _restaurantRepository;

  // Constructor - initial state: RestaurantDetailsInitial
  RestaurantDetailsBloc(this._restaurantRepository)
      : super(RestaurantDetailsInitial()) {
    on<TriggerGetRestaurantDetails>(_onTriggerGetRestaurantDetails);
  }

  // Handle TriggerGetRestaurantDetails
  void _onTriggerGetRestaurantDetails(
    TriggerGetRestaurantDetails event,
    Emitter<RestaurantDetailsState> emit,
  ) async {
    try {
      emit(RestaurantDetailsLoading());
      final restaurantDetails = await _restaurantRepository
          .getRestaurantDetailsById(event.restaurantId);
      emit(RestaurantDetailsSuccessful(restaurantDetails));
    } on GetRestaurantDetailsException catch (exception) {
      emit(RestaurantDetailsFailed(exception.errorMsg));
    }
  }
}
