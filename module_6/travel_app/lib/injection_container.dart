import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:travel_app/data/network/auth_service.dart';
import 'package:travel_app/data/network/firebase_api_service.dart';
import 'package:travel_app/data/network/travel_package_service.dart';
import 'package:travel_app/data/repository/booking_repository.dart';
import 'package:travel_app/data/repository/travel_package_repository.dart';
import 'package:travel_app/ui/booking/booking_bloc.dart';
import 'package:travel_app/ui/cancel/cancel_booking_bloc.dart';
import 'package:travel_app/ui/confirm/booking_confirm_bloc.dart';
import 'package:travel_app/ui/detail/detail_bloc.dart';
import 'package:travel_app/ui/home/home_bloc.dart';

void initKiwi() {
  final container = kiwi.KiwiContainer();

  ///Service
  container.registerSingleton((c) => AuthService());
  container.registerSingleton((c) => TravelPackageService());
  container.registerSingleton((c) => FirebaseApiService());

  ///Repository
  container.registerSingleton(
    (c) => TravelPackageRepository(
      c.resolve<TravelPackageService>(),
    ),
  );

  container.registerSingleton(
    (c) => BookingRepository(
      c.resolve<FirebaseApiService>(),
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

  container.registerFactory(
    (c) => BookingConfirmBloc(
      c.resolve<BookingRepository>(),
      c.resolve<TravelPackageRepository>(),
    ),
  );

  container.registerFactory(
    (c) => BookingBloc(
      c.resolve<BookingRepository>(),
    ),
  );

  container.registerFactory(
    (c) => CancelBookingBloc(
      c.resolve<BookingRepository>(),
    ),
  );
}
