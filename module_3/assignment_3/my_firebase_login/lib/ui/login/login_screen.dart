import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_firebase_login/ui/commons/styles.dart';
import 'package:my_firebase_login/ui/home/home_screen.dart';
import 'package:my_firebase_login/ui/login/bloc/login_bloc.dart';
import 'package:my_firebase_login/ui/login/bloc/login_event.dart';
import 'package:my_firebase_login/ui/login/bloc/login_state.dart';
import 'package:my_firebase_login/ui/registration/registration_screen.dart';

/// Todo 22: Create login screen
///   - provide login form
///   - implement login_bloc to trigger login

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _loginFormKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginFormKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginBloc = kiwi.KiwiContainer().resolve<LoginBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => _loginBloc,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 10.0,
          ),
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 12.0,
                ),
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccessful) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is LoginFailed) {
                      return buildLoginForm(_loginBloc, state.errorMsg);
                    } else if (state is LoginInitial) {
                      return buildLoginForm(_loginBloc, null);
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildLoginForm(LoginBloc loginBloc, String? errorMsg) {
    return SingleChildScrollView(
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login Form',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40.0),
            const Text('Email'),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _emailController,
              decoration: kLoginTextFieldStyle.copyWith(
                hintText: 'Enter your email here',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email should not be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            const Text('Password'),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _passwordController,
              decoration: kLoginTextFieldStyle.copyWith(
                hintText: 'Enter your password here',
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password should not be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              height: 32.0,
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  // Only allow login if both passed validation
                  if (_loginFormKey.currentState!.validate()) {
                    loginBloc.add(
                      TriggerLogin(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 32.0,
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black45,
                  ),
                ),
                child: const Text('Register for an account'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            errorMsg == null
                ? Container()
                : Container(
                    color: Colors.redAccent,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Text(
                          errorMsg,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
