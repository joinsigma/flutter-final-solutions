import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/authentication/login/login_bloc.dart';
import 'package:travel_app/ui/home/home_screen.dart';
import 'package:travel_app/ui/main_screen.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../../data/network/auth_service.dart';

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

  bool _isApiError = false;
  bool _isLoading = false;

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
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child:
              BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            }
          }, builder: (context, state) {
            if (state is LoginLoading) {
              return _buildLoginForm(isLoginError: false, isLoading: true);
            } else if (state is LoginInitial) {
              return _buildLoginForm(isLoginError: false, isLoading: false);
            } else if (state is LoginFailure) {
              return _buildLoginForm(isLoginError: true, isLoading: false);
            }
            return Container();
            // return Form(
            //   key: _loginFormKey,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(
            //         Icons.airplane_ticket,
            //         size: 40,
            //         color: Theme.of(context).primaryColor,
            //       ),
            //       const Text(
            //         'Login to Fire Travel',
            //         style: TextStyle(fontSize: 30.0),
            //       ),
            //       const SizedBox(
            //         height: 30.0,
            //       ),
            //       TextFormField(
            //         controller: _emailCtrl,
            //         decoration: const InputDecoration(
            //           icon: Icon(Icons.email),
            //           label: Text('Email'),
            //         ),
            //         validator: (value) {
            //           if (value == null || value.isEmpty) {
            //             return 'Please key in your email ID';
            //           }
            //           return null;
            //         },
            //       ),
            //       TextFormField(
            //         controller: _passwordCtrl,
            //         obscureText: true,
            //         decoration: const InputDecoration(
            //           icon: Icon(Icons.lock),
            //           label: Text('Password'),
            //         ),
            //         validator: (value) {
            //           if (value == null || value.isEmpty) {
            //             return 'Please key in your correct password';
            //           }
            //           return null;
            //         },
            //       ),
            //       const SizedBox(
            //         height: 30.0,
            //       ),
            //       _isLoading
            //           ? const CircularProgressIndicator()
            //           : SizedBox(
            //               width: double.infinity,
            //               child: ElevatedButton(
            //                 onPressed: () async {
            //                   ///Todo: Implement Login
            //                   Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                       builder: (context) => const MainScreen(),
            //                     ),
            //                   );
            //                   // final message = await AuthService().registration(
            //                   //   email: _emailCtrl.text,
            //                   //   password: _passwordCtrl.text,
            //                   // );
            //                   // if (message!.contains('Success')) {
            //                   //   Navigator.of(context).pushReplacement(
            //                   //       MaterialPageRoute(
            //                   //           builder: (context) => const HomeScreen()));
            //                   // }
            //                   // ScaffoldMessenger.of(context).showSnackBar(
            //                   //   SnackBar(
            //                   //     content: Text(message),
            //                   //   ),
            //                   // );
            //                 },
            //                 child: const Text(
            //                   'Login',
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //               ),
            //             ),
            //       if (_isApiError)
            //         const Text(
            //           'Login API Error, please retry',
            //           style: TextStyle(color: Colors.red),
            //         )
            //     ],
            //   ),
            // );
          }),
        ),
      ),
    );
  }

  Widget _buildLoginForm(
      {required bool isLoginError, required bool isLoading}) {
    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.airplane_ticket,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
          const Text(
            'Login to Fire Travel',
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
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
          if (isLoginError)
            const Text(
              'Login API Error, please retry',
              style: TextStyle(color: Colors.red),
            )
        ],
      ),
    );
  }
}
