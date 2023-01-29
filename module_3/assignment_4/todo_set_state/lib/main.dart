import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      home: const AuthenticationScreen(),
    );
  }
}
