import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_restaurant/data/network/rest_api_service.dart';
import 'package:my_restaurant/data/repository/restaurant_repository.dart';
import 'package:my_restaurant/ui/details/bloc/restaurant_details_bloc.dart';
import 'package:my_restaurant/ui/reviews/bloc/review_bloc.dart';
import 'package:my_restaurant/ui/search/bloc/search_restaurant_bloc.dart';

void initKiwi() {
  final container = kiwi.KiwiContainer();

  // Register services as Singleton
  container.registerSingleton((container) => RestApiService());

  // Register repository as Singleton
  container.registerSingleton(
    (container) => RestaurantRepository(
      container.resolve<RestApiService>(),
    ),
  );

  // Register bloc as Factory
  container.registerFactory(
    (container) => SearchRestaurantBloc(
      container.resolve<RestaurantRepository>(),
    ),
  );
  container.registerFactory(
    (container) => ReviewBloc(
      container.resolve<RestaurantRepository>(),
    ),
  );
  container.registerFactory(
    (container) => RestaurantDetailsBloc(
      container.resolve<RestaurantRepository>(),
    ),
  );
}
