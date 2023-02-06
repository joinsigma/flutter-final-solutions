import 'package:flutter/material.dart';
import 'package:todo_set_state/data/storage/local_storage_service.dart';
import 'package:todo_set_state/ui/authentication/authentication_screen.dart';
import 'package:todo_set_state/ui/listing/todo_list_screen.dart';

class CheckUserStatusScreen extends StatefulWidget {
  const CheckUserStatusScreen({Key? key}) : super(key: key);

  @override
  State<CheckUserStatusScreen> createState() => _CheckUserStatusScreenState();
}

class _CheckUserStatusScreenState extends State<CheckUserStatusScreen> {
  late LocalStorageService _localStorageService;

  @override
  void initState() {
    _localStorageService = LocalStorageService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _localStorageService.getAuthToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return const TodoListScreen();
              } else {
                return const AuthenticationScreen();
              }
            } else {
              return const AuthenticationScreen();
            }
          }
          return Container();
        },
      ),
    );
  }
}
