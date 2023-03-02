import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/authentication/login/bloc/login_bloc.dart';
import '../../listing/todo_list_screen.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late GlobalKey<FormState> _loginFormKey;

  @override
  void initState() {
    _loginBloc = kiwi.KiwiContainer().resolve<LoginBloc>();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _loginFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoListScreen(),
            ),
          );
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return _buildLoginForm(isLoginError: false, isLoading: true);
          } else if (state is LoginInitial) {
            return _buildLoginForm(isLoginError: false, isLoading: false);
          } else if (state is LoginFailure) {
            return _buildLoginForm(isLoginError: true, isLoading: false);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLoginForm(
      {required bool isLoginError, required bool isLoading}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_alt_rounded,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            const Text(
              'Login to Todoist',
              style: TextStyle(fontSize: 30.0),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                label: Text('Email'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please key in your email ID';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                label: Text('Password'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please key in your correct password';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 30.0,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        ///Validate the form here
                        if (_loginFormKey.currentState!.validate()) {
                          _loginBloc.add(
                            TriggerLogin(
                                email: _emailCtrl.text,
                                password: _passwordCtrl.text),
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
            if (isLoginError)
              const Text(
                'Login API Error, please retry',
                style: TextStyle(color: Colors.red),
              )
          ],
        ),
      ),
    );
  }
}
