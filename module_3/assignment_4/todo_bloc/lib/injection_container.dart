import 'package:flutter_todo_bloc/data/network/rest_api_service.dart';
import 'package:flutter_todo_bloc/data/storage/local_storage_service.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

void initKiwi() {
  final container = kiwi.KiwiContainer();

  ///Singleton
  container.registerSingleton((container) => RestApiService());
  container.registerSingleton((container) => LocalStorageService());

  
}
