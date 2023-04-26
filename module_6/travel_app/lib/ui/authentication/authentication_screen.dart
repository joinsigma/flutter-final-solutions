import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/authentication/authentication_bloc.dart';
import 'package:travel_app/ui/authentication/register/register_page.dart';
import 'package:travel_app/ui/home/home_screen.dart';
import 'package:travel_app/ui/main_screen.dart';
import 'login/login_page.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late AuthenticationBloc _authenticationBloc;
  late PageController _pageCtrl;
  int _currentPage = 0;

  @override
  void initState() {
    _authenticationBloc = kiwi.KiwiContainer().resolve<AuthenticationBloc>();
    _authenticationBloc.add(CheckUserStatus());
    _pageCtrl = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: Scaffold(
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
          if (state is AuthenticationSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthenticationFailure) {
            return PageView(
              controller: _pageCtrl,
              physics: const NeverScrollableScrollPhysics(),
              children: const [LoginPage(), RegisterPage()],
            );
          }
          return Container();
        }),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPage,
          onTap: (navItem) {
            setState(() {
              _pageCtrl.jumpToPage(navItem);
              _currentPage = navItem;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.login), label: "Login"),
            BottomNavigationBarItem(
                icon: Icon(Icons.touch_app), label: "Register"),
          ],
        ),
      ),
    );
  }
}
