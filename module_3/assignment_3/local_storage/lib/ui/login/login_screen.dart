import 'package:flutter/material.dart';
import 'package:local_storage/data/network/rest_api_service.dart';
import 'package:local_storage/data/storage/local_storage_service.dart';
import 'package:local_storage/ui/home/home_screen.dart';

import '../common/styles.dart';
import '../register/registration_screen.dart';

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

  ///Lesson code
  RestApiService _restApiService = RestApiService();
  LocalStorageService _localStorageService = LocalStorageService();
  bool isLoading = false;

  @override
  void initState() {
    _loginFormKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Card(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22.0,
                        vertical: 12.0,
                      ),
                      child: buildLoginForm(null)),
                ),
        ),
      ),
    );
  }

  SingleChildScrollView buildLoginForm(String? errorMsg) {
    return SingleChildScrollView(
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Login Form',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w600,
                ),
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
                onPressed: () async {
                  // Only allow login if both passed validation
                  if (_loginFormKey.currentState!.validate()) {
                    ///Todo: Call API for login
                    setState(() {
                      isLoading = true;
                    });
                    final user = await _restApiService.signInUsingEmailPassword(
                        _emailController.text, _passwordController.text);
                    final isSaved = await _localStorageService.saveUserToken(
                        user.authToken, user.refreshToken);
                    setState(() {
                      isLoading = false;
                    });
                    if (!mounted) return;
                    if (isSaved) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
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
