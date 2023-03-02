import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_todo_bloc/ui/authentication/register/registration_page.dart';
import 'package:flutter_todo_bloc/ui/common/widgets/loading_indicator.dart';
import '../listing/todo_list_screen.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authentication_state.dart';
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
    ///Add event
    _authenticationBloc.add(CheckUserStatus());
    _pageCtrl = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
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
                builder: (context) => const TodoListScreen(),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const LoadingIndicator();
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
