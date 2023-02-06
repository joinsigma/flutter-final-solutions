import 'package:flutter/material.dart';
import 'package:todo_set_state/data/network/rest_api_service.dart';
import 'package:todo_set_state/data/storage/local_storage_service.dart';

import '../../../data/network/exceptions.dart';
import '../../listing/todo_list_screen.dart';

class LoginForm extends StatefulWidget {
  // final TextEditingController _emailCtrl;
  // final TextEditingController _passwordCtrl;
  // final String? errorMsg;
  const LoginForm({
    Key? key,
    // required this.passwordCtrl,
    // required this.emailCtrl,
    // this.errorMsg
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late RestApiService _restApiService;
  late LocalStorageService _localStorageService;
  late GlobalKey<FormState> _loginFormKey;
  bool _isApiError = false;
  bool _isLoading = false;

  @override
  void initState() {
    ///Initiate all variables
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _restApiService = RestApiService();
    _localStorageService = LocalStorageService();
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
    return Form(
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
            "Login to Todoist",
            style: TextStyle(fontSize: 30.0),
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please key in your email ID';
              }
            },
            controller: _emailCtrl,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              label: Text('Email'),
            ),
          ),
          TextFormField(
            controller: _passwordCtrl,
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              label: Text('Password'),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),

          ///Loading indicator
          _isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400]),
                    onPressed: () async {
                      ///Validate form
                      if (_loginFormKey.currentState!.validate()) {
                        try {
                          setState(() {
                            _isLoading = true;
                          });

                          ///Call API to Login.
                          final result =
                              await _restApiService.signInUsingEmailPassword(
                                  email: _emailCtrl.text,
                                  password: _passwordCtrl.text);

                          ///Save token in local storage
                          _localStorageService.saveToken(
                              authToken: result.authToken,
                              refreshToken: result.refreshToken);

                          ///Save userId in local storage
                          _localStorageService.saveUserId(result.uid);

                          ///If login successful navigate to TodoListScreen.
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TodoListScreen(),
                            ),
                          );
                        } on UserLoginError catch (_) {
                          ///If unsuccessful update error message for display
                          setState(() {
                            _isLoading = false;
                            _isApiError = true;
                          });
                        } on AuthTokenErrorException catch (_) {
                          ///If unsuccessful update error message for display
                          setState(() {
                            _isLoading = false;
                            _isApiError = true;
                          });
                        } on UidErrorException catch (_) {
                          ///If unsuccessful update error message for display
                          setState(() {
                            _isLoading = false;
                            _isApiError = true;
                          });
                        }
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
          const SizedBox(
            height: 20.0,
          ),

          ///Display error if error flag = true
          if (_isApiError)
            const Text(
              'Login API Error, please retry.',
              style: TextStyle(color: Colors.red),
            )
        ],
      ),
    );
  }
}
