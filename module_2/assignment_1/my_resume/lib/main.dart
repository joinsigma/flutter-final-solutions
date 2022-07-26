import 'package:flutter/material.dart';
import 'package:my_resume/profile/profile_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My Resume',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const ProfileScreen(),
    ),
  );
}
