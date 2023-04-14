import 'package:flutter/material.dart';
import 'package:travel_app/ui/home/home_screen.dart';
import 'package:travel_app/ui/main_screen.dart';

import '../../data/network/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late GlobalKey<FormState> _loginFormKey;

  bool _isApiError = false;
  bool _isLoading = false;

  @override
  void initState() {
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _loginFormKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          ///Todo: Implement Login
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                          );
                          // final message = await AuthService().registration(
                          //   email: _emailCtrl.text,
                          //   password: _passwordCtrl.text,
                          // );
                          // if (message!.contains('Success')) {
                          //   Navigator.of(context).pushReplacement(
                          //       MaterialPageRoute(
                          //           builder: (context) => const HomeScreen()));
                          // }
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(message),
                          //   ),
                          // );
                        },
                        child: const Text('Login'),
                      ),
                    ),
              if (_isApiError)
                const Text(
                  'Login API Error, please retry',
                  style: TextStyle(color: Colors.red),
                )
            ],
          ),
        ),
      ),
    );
  }
}
