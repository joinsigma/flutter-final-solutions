import 'package:flutter/material.dart';
import '../../data/network/exceptions.dart';
import '../../data/network/rest_api_service.dart';
import '../../data/storage/exceptions.dart';
import '../../data/storage/local_storage_service.dart';
import '../listing/todo_list_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late GlobalKey<FormState> _loginFormKey;
  late RestApiService _restApiService;
  late LocalStorageService _localStorageService;

  bool _isApiError = false;
  bool _isLoading = false;

  @override
  void initState() {
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _loginFormKey = GlobalKey<FormState>();
    _restApiService = RestApiService();
    _localStorageService = LocalStorageService();
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
            _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  ///Validate the form here
                  if (_loginFormKey.currentState!.validate()) {
                    try{
                      setState(() {
                        _isLoading = true;
                      });

                      ///Call API to Login
                      final result =
                      await _restApiService.signInUsingEmailPassword(
                          email: _emailCtrl.text,
                          password: _passwordCtrl.text);

                      ///Save the auth token in to local storage
                      _localStorageService.saveToken(result.authToken);

                      ///Save user Id in local storage
                      _localStorageService.saveUserId(result.uid);

                      ///Navigate to the Home Screen
                      if(mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TodoListScreen(),
                          ),
                        );
                      }
                    }
                    on UserLoginError catch(_){
                      setState(() {
                        _isLoading = false;
                        _isApiError = true;
                      });
                    }
                    on AuthTokenErrorException catch(_){
                      setState(() {
                        _isLoading = false;
                        _isApiError = true;
                      });
                    }
                    on UidErrorException catch(_){
                      setState(() {
                        _isLoading = false;
                        _isApiError = true;
                      });
                    }
                  }
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
    );
  }
}