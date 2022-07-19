import 'package:flutter/material.dart';
import 'package:my_whatsapp/commons/styles.dart';
import 'package:my_whatsapp/screens/call/call_screen.dart';
import 'package:my_whatsapp/screens/chat/chat_screen.dart';
import 'package:my_whatsapp/screens/settings/settings_screen.dart';
import 'package:my_whatsapp/screens/status/status_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My WhatsApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  final screens = [
    const StatusScreen(),
    const CallScreen(),
    const Center(child: Text('Camera', style: kPageTitleStyle)),
    const ChatScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11.0,
        unselectedFontSize: 11.0,
        iconSize: 26.0,
        backgroundColor: Colors.grey[200],
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.black54,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications_outlined),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
