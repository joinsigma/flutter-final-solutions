import 'package:flutter/material.dart';
import 'package:local_storage/data/storage/local_storage_service.dart';
import 'package:local_storage/ui/home/home_screen.dart';
import 'package:local_storage/ui/login/login_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final LocalStorageService _localStorageService = LocalStorageService();

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
            if (snapshot.data != null) {
              ///If Auth Token valid, return Home Screen.
              return const HomeScreen();
            } else {
              ///If Auth Token not valid, return Login Screen.
              return const LoginScreen();
            }
          }
          return Container();
        },
      ),
    );
  }
}
