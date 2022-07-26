import 'package:flutter/material.dart';
import 'package:my_insta/profile/profile_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My Insta',
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
    const Center(child: Text('Home')),
    const ProfileScreen(),
    const Center(child: Text('Post')),
    const Center(child: Text('Favourite')),
    const Center(child: Text('Photo')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 38.0,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          iconSize: 26.0,
          onTap: (value) => setState(
            () {
              _currentIndex = value;
            },
          ),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album_outlined),
              label: 'Photo',
            ),
          ],
        ),
      ),
    );
  }
}
