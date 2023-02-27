import 'package:flutter/material.dart';
import '../../data/network/exceptions.dart';
import '../../data/network/rest_api_service.dart';
import '../../data/storage/exceptions.dart';
import '../../data/storage/local_storage_service.dart';
import '../listing/todo_list_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late GlobalKey<FormState> _registerFormKey;
  late RestApiService _restApiService;
  late LocalStorageService _localStorageService;

  bool _isLoading = false;
  bool _isApiError = false;

  @override
  void initState() {
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _registerFormKey = GlobalKey<FormState>();
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
        key: _registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_alt_rounded,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            const Text(
              'Register to Todoist',
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
                }),
            const SizedBox(
              height: 30.0,
            ),
            _isLoading ? const CircularProgressIndicator() :
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  ///Validate the form here
                  if (_registerFormKey.currentState!.validate()) {
                    try {
                      ///Update loading state
                      setState(() {
                        _isLoading = true;
                      });

                      ///Call Register API
                      final result =
                      await _restApiService.registerWithEmailPassword(
                          email: _emailCtrl.text,
                          password: _passwordCtrl.text);

                      ///Save the Auth Token
                      _localStorageService.saveToken(result.authToken);

                      ///Save the User Id
                      _localStorageService.saveUserId(result.uid);

                      ///Navigate to home screen
                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TodoListScreen(),
                          ),
                        );
                      }
                    } on UserRegistrationError catch (_) {
                      setState(() {
                        _isLoading = false;
                        _isApiError = true;
                      });
                    }
                    on AuthTokenErrorException catch (_) {
                      setState(() {
                        _isLoading = false;
                        _isApiError = true;
                      });
                    }
                    on UidErrorException catch (_) {
                      setState(() {
                        _isLoading = false;
                        _isApiError = true;
                      });
                    }
                  }
                },
                child: const Text('Register'),
              ),
            ),
            if (_isApiError)
              const Text('Register API error, please retry.',
                  style: TextStyle(color: Colors.red))
          ],
        ),
      ),
    );
  }
}
