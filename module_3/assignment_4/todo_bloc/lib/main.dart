import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/ui/authentication/authentication_screen.dart';


void main() {
  runApp(const MyApp());
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final
//   @override
//   void initState() {
//
//     super.initState();
//   }
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => _mainBloc,
//       child: MaterialApp(
//         title: 'Flutter Todo',
//         theme: ThemeData(
//           primarySwatch: Colors.deepOrange,
//         ),
//         home: const AuthenticationScreen(),
//       ),
//     );
//   }
// }


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