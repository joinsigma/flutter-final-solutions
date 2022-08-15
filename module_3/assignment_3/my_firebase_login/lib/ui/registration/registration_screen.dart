import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:my_firebase_login/ui/commons/styles.dart';
import 'package:my_firebase_login/ui/home/home_screen.dart';
import 'package:my_firebase_login/ui/login/login_screen.dart';
import 'package:my_firebase_login/ui/registration/bloc/registration_bloc.dart';
import 'package:my_firebase_login/ui/registration/bloc/registration_event.dart';
import 'package:my_firebase_login/ui/registration/bloc/registration_state.dart';

/// Todo 24: Create Registration Screen
///   - implement registration_bloc

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationBloc _registrationBloc;
  late GlobalKey<FormState> _registrationFormKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _registrationBloc = kiwi.KiwiContainer().resolve<RegistrationBloc>();
    _registrationFormKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _registrationBloc.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => _registrationBloc,
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
                child: BlocConsumer<RegistrationBloc, RegistrationState>(
                  listener: (context, state) {
                    if (state is RegistrationSuccessful) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is RegistrationLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is RegistrationFailed) {
                      return buildRegistrationForm(
                          _registrationBloc, state.errorMsg);
                    } else if (state is RegistrationInitial) {
                      return buildRegistrationForm(_registrationBloc, null);
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

  SingleChildScrollView buildRegistrationForm(
    RegistrationBloc registrationBloc,
    String? errorMsg,
  ) {
    return SingleChildScrollView(
      child: Form(
        key: _registrationFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Registration Form',
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
                child: const Text('Register'),
                onPressed: () {
                  // Only allow login if both passed validation
                  if (_registrationFormKey.currentState!.validate()) {
                    registrationBloc.add(
                      TriggerRegistration(
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
                child: const Text('Have an account?'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
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
