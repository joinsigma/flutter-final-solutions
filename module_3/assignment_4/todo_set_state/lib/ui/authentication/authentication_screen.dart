import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/authentication/registration_page.dart';
import 'package:flutter_todo_bloc/ui/listing/todo_list_screen.dart';
import 'bloc/login_page_bloc.dart';
import 'bloc/registration_page_bloc.dart';
import 'login_page.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late PageController _pageCtrl;
  int _currentPage = 0;
  // late LoginBloc _loginBloc;
  // late RegistrationBloc _registrationBloc;

  @override
  void initState() {
    // _loginBloc = kiwi.KiwiContainer().resolve<LoginBloc>();
    // _registrationBloc = kiwi.KiwiContainer().resolve<RegistrationBloc>();
    // _loginBloc.add(CheckUserStatus());
    _pageCtrl = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // _loginBloc.close();
    // _registrationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageCtrl,
        children: const [
          LoginPage(),
          RegistrationPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        selectedItemColor: Colors.red[400],
        onTap: (navItem) {
          setState(() {
            _currentPage = navItem;
            _pageCtrl.animateToPage(
              navItem,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: "Login",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: "Register",
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: PageView(
  //       physics: const NeverScrollableScrollPhysics(),
  //       controller: _pageCtrl,
  //       children: [
  //         BlocProvider(
  //           create: (context) => _loginBloc,
  //           child: const LoginPage(),
  //         ),
  //         BlocProvider(
  //           create: (context) => _registrationBloc,
  //           child: const RegistrationPage(),
  //         )
  //       ],
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       currentIndex: _currentPage,
  //       selectedItemColor: Theme.of(context).primaryColor,
  //       onTap: (navItem) {
  //         setState(() {
  //           _currentPage = navItem;
  //           _pageCtrl.animateToPage(
  //             navItem,
  //             duration: const Duration(milliseconds: 500),
  //             curve: Curves.ease,
  //           );
  //         });
  //       },
  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.login),
  //           label: "Login",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.touch_app),
  //           label: "Register",
  //         )
  //       ],
  //     ),
  //   );
  // }
}
