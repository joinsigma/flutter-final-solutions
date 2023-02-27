import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/ui/listing/widgets/todo_listview.dart';

import '../../data/model/todo.dart';
import '../../data/network/exceptions.dart';
import '../../data/network/rest_api_service.dart';
import '../../data/storage/local_storage_service.dart';
import '../add/todo_add_screen.dart';
import '../authentication/authentication_screen.dart';
import '../common/widgets/loading_indicator.dart';
import '../common/widgets/login_redirect_display.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late RestApiService _restApiService;
  late LocalStorageService _localStorageService;

  @override
  void initState() {
    _restApiService = RestApiService();
    _localStorageService = LocalStorageService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: const Text('My Todos'),
        actions: [
          GestureDetector(
            onTap: () {
              _localStorageService.deleteToken();
              _localStorageService.deleteUserId();

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthenticationScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: _restApiService.getAllTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            ///Check for Error
            if (snapshot.hasError) {
              if (snapshot.error is NotAuthorizedError) {
                return const LoginRedirectDisplay();
              }
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            ///Check for data
            else if (snapshot.hasData) {
              var todos = snapshot.data!;
              return TodoListView(todos: todos);
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
    );
  }
}
