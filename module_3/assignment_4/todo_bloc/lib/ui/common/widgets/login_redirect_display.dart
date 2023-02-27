import 'package:flutter/material.dart';
import '../../authentication/authentication_screen.dart';

class LoginRedirectDisplay extends StatelessWidget {
  const LoginRedirectDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Session has expired, please referesh..'),
          ElevatedButton(
            onPressed: () {
              ///Redirect user to Login Screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthenticationScreen(),
                ),
              );
            },
            child: const Text('Go to Login'),
          )
        ],
      ),
    );
  }
}
