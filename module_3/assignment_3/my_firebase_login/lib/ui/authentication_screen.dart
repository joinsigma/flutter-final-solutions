import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_firebase_login/ui/home/home_screen.dart';
import 'package:my_firebase_login/ui/login/bloc/login_bloc.dart';
import 'package:my_firebase_login/ui/login/bloc/login_event.dart';
import 'package:my_firebase_login/ui/login/bloc/login_state.dart';
import 'package:my_firebase_login/ui/login/login_screen.dart';
import 'package:my_firebase_login/ui/registration/bloc/registration_bloc.dart';

/// Todo 21: Create authentication screen
///   - When page loads, check whether user has signed in
///   - If logged in, navigate user to main screen
///   - If not logged in, display login screen

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  late LoginBloc _loginBloc;
  late RegistrationBloc _registrationBloc;

  @override
  void initState() {
    _loginBloc = kiwi.KiwiContainer().resolve<LoginBloc>();
    _registrationBloc = kiwi.KiwiContainer().resolve<RegistrationBloc>();
    _loginBloc.add(ValidateUserStatus());
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    _registrationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _loginBloc,
          ),
          BlocProvider(
            create: (context) => _registrationBloc,
          ),
        ],
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginNotRequired) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }

            if (state is LoginInitial) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          },
          child: Container(),
        ),
      ),
    );
  }
}
