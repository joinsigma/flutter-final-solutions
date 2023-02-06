import 'package:flutter/material.dart';
import 'package:todo_set_state/data/network/exceptions.dart';
import 'package:todo_set_state/data/network/rest_api_service.dart';
import 'package:todo_set_state/data/storage/local_storage_service.dart';
import 'package:todo_set_state/ui/authentication/authentication_screen.dart';
import 'package:todo_set_state/ui/common/widgets/loading_indicator.dart';
import 'package:todo_set_state/ui/common/widgets/login_redirect_display.dart';
import 'package:todo_set_state/ui/listing/widgets/todo_listview.dart';

import '../../data/model/todo.dart';
import '../add/todo_add_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late LocalStorageService _localStorageService;
  late RestApiService _restApiService;

  @override
  void initState() {
    _restApiService = RestApiService();
    _localStorageService = LocalStorageService();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red[400],
        title: const Text('My Todos'),
        actions: [
          GestureDetector(
            onTap: () {
              ///Clear token
              _localStorageService.deleteToken();
              _localStorageService.deleteUserId();

              ///Navigate to Authentication screen.
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthenticationScreen(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      // body: _isLoading
      //     ? const LoadingIndicator()
      body: FutureBuilder<List<Todo>>(
          future: _restApiService.getAllTodos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                ///UI if API not authorized and require token refresh.
                if (snapshot.error is NotAuthorizedError) {
                  return const LoginRedirectDisplay();
                }

                ///UI for general error display.
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              } else if (snapshot.hasData) {
                var todos = snapshot.data!;
                return TodoListView(
                  todos: todos,
                );
              }
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
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
    );
  }
}
