import 'package:flutter/material.dart';
import 'package:todo_set_state/ui/common/widgets/loading_indicator.dart';
import '../../data/network/exceptions.dart';
import '../../data/network/rest_api_service.dart';
import '../../data/storage/exceptions.dart';
import '../../data/storage/local_storage_service.dart';
import '../listing/todo_list_screen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late RestApiService _restApiService;
  late LocalStorageService _localStorageService;
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late GlobalKey<FormState> _registerFormKey;
  bool _isApiError = false;
  bool _isLoading = false;

  @override
  void initState() {
    _restApiService = RestApiService();
    _localStorageService = LocalStorageService();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _registerFormKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
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
              "Register to Todoist",
              style: TextStyle(fontSize: 30.0),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
              controller: _emailCtrl,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                label: Text('Email'),
              ),
            ),
            TextField(
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
            _isLoading
                ? const LoadingIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400]),
                      onPressed: () async {
                        ///Validate form
                        if (_registerFormKey.currentState!.validate()) {
                          try {
                            ///Update state to loading
                            setState(() {
                              _isLoading = true;
                            });

                            ///Call Register API
                            final result =
                                await _restApiService.registerWithEmailPassword(
                                    email: _emailCtrl.text,
                                    password: _passwordCtrl.text);

                            ///Save token in local storage
                            _localStorageService.saveToken(
                                authToken: result.authToken,
                                refreshToken: result.refreshToken);

                            ///Save userId in local storage
                            _localStorageService.saveUserId(result.uid);

                            if (!mounted) return;

                            ///If register successful navigate to TodoListScreen.
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TodoListScreen(),
                              ),
                            );
                          } on UserRegistrationError catch (_) {
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
                      child: const Text('Register'),
                    ),
                  ),
            const SizedBox(
              height: 20.0,
            ),

            ///Display error if error flag = true
            if (_isApiError)
              const Text(
                'Register API Error, please retry.',
                style: TextStyle(color: Colors.red),
              )
          ],
        ),
      ),
    );
  }
}
