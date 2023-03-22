import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/listing/bloc/todo_list_bloc.dart';
import 'package:flutter_todo_bloc/ui/listing/bloc/todo_list_event.dart';
import 'package:flutter_todo_bloc/ui/listing/bloc/todo_list_state.dart';
import 'package:flutter_todo_bloc/ui/listing/widgets/todo_listview.dart';

import '../add/todo_add_screen.dart';
import '../authentication/authentication_screen.dart';
import '../common/widgets/api_error_display.dart';
import '../common/widgets/loading_indicator.dart';
import '../common/widgets/login_redirect_display.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../common/widgets/network_error_display.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late TodoListBloc _todoListBloc;

  @override
  void initState() {
    _todoListBloc = kiwi.KiwiContainer().resolve<TodoListBloc>();
    _todoListBloc.add(LoadTodoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _todoListBloc,
      child: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: const Text('My Todos'),
          actions: [
            GestureDetector(
              onTap: () {
                ///Add event
                _todoListBloc.add(TriggerLogout());
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.logout),
              ),
            )
          ],
        ),
        body: BlocConsumer<TodoListBloc, TodoListState>(
          listener: (context, state) {
            if (state is LoggedOut) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthenticationScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is TodoListLoading) {
              return const LoadingIndicator();
            } else if (state is TodoListSuccess) {
              return TodoListView(todos: state.todos);
            } else if (state is TodoListFailure) {
              if (state.isNetworkError) {
                return const NetworkErrorDisplay();
              } else if (state.isSessionExpired) {
                // _todoListBloc.add(ResetToken());
                return const LoginRedirectDisplay();
              } else if (state.isApiError) {
                return const ApiErrorDisplay();
              }
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TodoAddScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
