import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:travel_app/data/network/firebase_api_service.dart';
import 'package:travel_app/data/repository/booking_repository.dart';
import 'package:travel_app/data/repository/travel_package_repository.dart';
import 'package:travel_app/data/repository/user_repository.dart';
import 'package:travel_app/data/storage/local_storage_service.dart';
import 'package:travel_app/ui/authentication/authentication_bloc.dart';
import 'package:travel_app/ui/authentication/login/login_bloc.dart';
import 'package:travel_app/ui/authentication/register/register_bloc.dart';
import 'package:travel_app/ui/booking/booking_bloc.dart';
import 'package:travel_app/ui/cancel/cancel_booking_bloc.dart';
import 'package:travel_app/ui/confirm/booking_confirm_bloc.dart';
import 'package:travel_app/ui/detail/detail_bloc.dart';
import 'package:travel_app/ui/home/home_bloc.dart';
import 'package:travel_app/ui/likes/likes_bloc.dart';

void initKiwi() {
  final container = kiwi.KiwiContainer();

  ///Service
  container.registerSingleton((c) => FirebaseApiService());
  container.registerSingleton((c) => LocalStorageService());

  ///Repository
  container.registerSingleton(
    (c) => TravelPackageRepository(
      c.resolve<FirebaseApiService>(),
    ),
  );

  container.registerSingleton(
    (c) => BookingRepository(
      c.resolve<FirebaseApiService>(),
    ),
  );
  container.registerSingleton(
    (c) => UserRepository(
      c.resolve<FirebaseApiService>(),
      c.resolve<LocalStorageService>(),
    ),
  );

  ///Bloc
  container.registerFactory(
    (c) => AuthenticationBloc(
      c.resolve<UserRepository>(),
    ),
  );

  container.registerFactory(
        (c) => LoginBloc(
      c.resolve<UserRepository>(),
    ),
  );

  container.registerFactory(
        (c) => RegisterBloc(
      c.resolve<UserRepository>(),
    ),
  );

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

  container.registerFactory(
    (c) => LikesBloc(
      c.resolve<TravelPackageRepository>(),
    ),
  );
}
