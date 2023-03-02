import 'package:flutter_todo_bloc/data/network/rest_api_service.dart';
import 'package:flutter_todo_bloc/data/repository/todo_repository.dart';
import 'package:flutter_todo_bloc/data/storage/local_storage_service.dart';
import 'package:flutter_todo_bloc/ui/add/bloc/todo_add_bloc.dart';
import 'package:flutter_todo_bloc/ui/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_todo_bloc/ui/authentication/login/bloc/login_bloc.dart';
import 'package:flutter_todo_bloc/ui/authentication/register/bloc/register_bloc.dart';
import 'package:flutter_todo_bloc/ui/detail/bloc/todo_detail_bloc.dart';
import 'package:flutter_todo_bloc/ui/edit/bloc/todo_edit_bloc.dart';
import 'package:flutter_todo_bloc/ui/listing/bloc/todo_list_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'data/repository/user_repository.dart';

void initKiwi() {
  final container = kiwi.KiwiContainer();

  ///Service
  container.registerSingleton((c) => RestApiService());
  container.registerSingleton((c) => LocalStorageService());

  ///Repository
  container.registerSingleton(
    (c) => UserRepository(
      c.resolve<RestApiService>(),
      c.resolve<LocalStorageService>(),
    ),
  );

  container.registerSingleton(
    (c) => TodoRepository(
      c.resolve<RestApiService>(),
      c.resolve<LocalStorageService>(),
    ),
  );

  ///Bloc
  container.registerFactory(
    (c) => TodoAddBloc(
      c.resolve<UserRepository>(),
      c.resolve<TodoRepository>(),
    ),
  );

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
    (c) => TodoDetailBloc(
      c.resolve<TodoRepository>(),
    ),
  );

  container.registerFactory(
    (c) => TodoEditBloc(
      c.resolve<TodoRepository>(),
    ),
  );

  container.registerFactory(
    (c) => TodoListBloc(
      c.resolve<TodoRepository>(),
      c.resolve<LocalStorageService>(),
    ),
  );
}
