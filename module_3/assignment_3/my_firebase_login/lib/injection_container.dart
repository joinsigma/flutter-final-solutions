import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_firebase_login/data/network/rest_api_service.dart';
import 'package:my_firebase_login/data/repository/user_repository.dart';
import 'package:my_firebase_login/data/storage/local_storage_service.dart';
import 'package:my_firebase_login/ui/login/bloc/login_bloc.dart';
import 'package:my_firebase_login/ui/logout/bloc/logout_bloc.dart';
import 'package:my_firebase_login/ui/registration/bloc/registration_bloc.dart';

/// Todo 19: Implement kiwi container
///   - Singleton: services, repository
///   - Factory: bloc

void initKiwi() {
  final container = kiwi.KiwiContainer();

  // Register services as Singleton
  container.registerSingleton((container) => RestApiService());

  container.registerSingleton((container) => LocalStorageService());

  // Register repository as Singleton
  container.registerSingleton(
    (container) => UserRepository(
      container.resolve<RestApiService>(),
      container.resolve<LocalStorageService>(),
    ),
  );

  // Register bloc as Factory
  container.registerFactory(
    (container) => RegistrationBloc(
      container.resolve<UserRepository>(),
    ),
  );

  container.registerFactory(
    (container) => LoginBloc(
      container.resolve<UserRepository>(),
    ),
  );

  container.registerFactory(
    (container) => LogoutBloc(
      container.resolve<LocalStorageService>(),
    ),
  );
}
