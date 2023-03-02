import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/authentication/register/bloc/register_bloc.dart';
import '../../listing/todo_list_screen.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'bloc/register_event.dart';
import 'bloc/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterBloc _registerBloc;
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late GlobalKey<FormState> _registerFormKey;

  @override
  void initState() {
    _registerBloc = kiwi.KiwiContainer().resolve<RegisterBloc>();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _registerFormKey = GlobalKey<FormState>();
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
    return BlocProvider(
      create: (context) => _registerBloc,
      child: BlocConsumer(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TodoListScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
            return _buildRegisterForm(isRegisterError: false, isLoading: true);
          } else if (state is RegisterInitial) {
            return _buildRegisterForm(isRegisterError: false, isLoading: false);
          } else if (state is RegisterFailure) {
            return _buildRegisterForm(isRegisterError: true, isLoading: false);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildRegisterForm(
      {required bool isRegisterError, required bool isLoading}) {
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
            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        ///Validate the form here
                        if (_registerFormKey.currentState!.validate()) {
                          _registerBloc.add(
                            TriggerRegister(
                                email: _emailCtrl.text,
                                password: _passwordCtrl.text),
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
            if (isRegisterError)
              const Text('Register API error, please retry.',
                  style: TextStyle(color: Colors.red))
          ],
        ),
      ),
    );
  }
}
