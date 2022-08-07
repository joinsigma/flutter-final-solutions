import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_crypto_bloc/data/network/rest_api_service.dart';
import 'package:my_crypto_bloc/data/repository/crypto_repository.dart';
import 'package:my_crypto_bloc/ui/details/bloc/crypto_details_bloc.dart';
import 'package:my_crypto_bloc/ui/home/bloc/home_page_bloc.dart';
import 'package:my_crypto_bloc/ui/search/bloc/search_crypto_bloc.dart';

/// Todo 14: Create kiwi container & register bloc, repository & services
/// - register services as Singleton
/// - register repository as Singleton
/// - register bloc as Factory
void initKiwi() {
  final container = kiwi.KiwiContainer();

  // Register services as singleton
  container.registerSingleton(
    (container) => RestApiService(),
  );

  // Register repository as singleton
  container.registerSingleton(
    (container) => CryptoRepository(
      container.resolve<RestApiService>(),
    ),
  );

  // Register bloc as factory
  container.registerFactory(
    (container) => HomepageBloc(
      container.resolve<CryptoRepository>(),
    ),
  );

  container.registerFactory(
    (container) => SearchCryptoBloc(
      container.resolve<CryptoRepository>(),
    ),
  );

  container.registerFactory(
    (container) => CryptoDetailsBloc(
      container.resolve<CryptoRepository>(),
    ),
  );
}
