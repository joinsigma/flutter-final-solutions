import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/ui/authentication/registration_page.dart';
import 'login_page.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late PageController _pageCtrl;
  int _currentPage=0;

  @override
  void initState() {
    _pageCtrl = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageCtrl,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          LoginPage(),
          RegisterPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (navItem){
          setState(() {
            _pageCtrl.jumpToPage(navItem);
            _currentPage = navItem;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.login),label: "Login"),
          BottomNavigationBarItem(icon: Icon(Icons.touch_app),label: "Register"),
        ],
      ),
    );
  }
}
