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
          const Text('Session expired, please refresh.'),
          ElevatedButton(
            onPressed: () async {
              ///Redirect user to Login screen.
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
