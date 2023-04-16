import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:travel_app/data/network/auth_service.dart';
import 'package:travel_app/data/network/travel_package_service.dart';
import 'package:travel_app/data/repository/travel_package_repository.dart';
import 'package:travel_app/ui/detail/detail_bloc.dart';
import 'package:travel_app/ui/home/home_bloc.dart';

void initKiwi() {
  final container = kiwi.KiwiContainer();

  ///Service
  container.registerSingleton((c) => AuthService());
  container.registerSingleton((c) => TravelPackageService());

  ///Repository
  container.registerSingleton(
    (c) => TravelPackageRepository(
      c.resolve<TravelPackageService>(),
    ),
  );

  ///Bloc
  container.registerFactory(
    (c) => HomeBloc(
      c.resolve<TravelPackageRepository>(),
    ),
  );

  container.registerFactory(
    (c) => DetailBloc(
      c.resolve<TravelPackageRepository>(),
    ),
  );
}
