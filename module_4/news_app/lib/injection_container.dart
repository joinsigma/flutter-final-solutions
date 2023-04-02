import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:news_app/ui/news_bloc.dart';
import 'package:news_app/data/news_repository.dart';
import 'package:news_app/data/rest_api_service.dart';

void initKiwi() {
  final container = kiwi.KiwiContainer();

  container.registerSingleton((c) => RestApiService());

  container.registerSingleton(
    (c) => NewsRepository(
      c.resolve<RestApiService>(),
    ),
  );

  container.registerFactory(
    (c) => NewsBloc(
      c.resolve<NewsRepository>(),
    ),
  );
}
