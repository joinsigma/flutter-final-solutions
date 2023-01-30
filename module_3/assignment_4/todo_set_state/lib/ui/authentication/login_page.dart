import 'package:flutter/material.dart';
import 'package:todo_set_state/ui/authentication/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  @override
  void initState() {
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
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
      child: LoginForm(
        passwordCtrl: _passwordCtrl,
        emailCtrl: _emailCtrl,
        errorMsg: 'Error',
      ),
    );
  }
}
