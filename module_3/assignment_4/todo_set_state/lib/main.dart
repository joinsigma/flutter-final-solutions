import 'package:flutter/material.dart';
import 'package:todo_set_state/ui/authentication/authentication_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todoist',
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
