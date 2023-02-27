import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/injection_container.dart';
import 'package:flutter_todo_bloc/ui/authentication/authentication_screen.dart';

void main() {
  initKiwi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: Theme.of(context).copyWith(
        ///Set primary color for the app (in main widgets such as icon color,appbar etc..)
        primaryColor: Colors.red[400],

        ///Set primary for all input field related widgets.
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Colors.red[400],
        ),
      ),
      home: const AuthenticationScreen(),
    );
  }
}