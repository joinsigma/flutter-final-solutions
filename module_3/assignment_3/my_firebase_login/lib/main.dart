import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_login/injection_container.dart';
import 'package:my_firebase_login/ui/authentication_screen.dart';

import 'firebase_options.dart';

/// Todo 1: Install Firebase CLI

/// Todo 2: Install necessary packages
///   - firebase auth: [ flutter pub add firebase_auth firebase_core ]
///   - bloc: [ flutter pub add bloc flutter_bloc kiwi equatable ]
///   - rest: [ flutter pub add http ]

void main() async {
  /// Todo 3: Initialized firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Todo 20: Invoke initKiwi()
  initKiwi();

  runApp(
    MaterialApp(
      title: 'My Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthenticationScreen(),
    ),
  );
}
