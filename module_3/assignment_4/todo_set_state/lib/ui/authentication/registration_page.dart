import 'package:flutter/material.dart';
import 'package:todo_set_state/ui/authentication/widgets/registration_form.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // late TextEditingController _usernameCtrl;
  // late TextEditingController _emailCtrl;
  // late TextEditingController _passwordCtrl;
  // late TextEditingController _ageCtrl;

  @override
  void initState() {
    // _usernameCtrl = TextEditingController();
    // _emailCtrl = TextEditingController();
    // _passwordCtrl = TextEditingController();
    // _ageCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // _usernameCtrl.dispose();
    // _passwordCtrl.dispose();
    // _emailCtrl.dispose();
    // _ageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: RegistrationForm(
          // passwordCtrl: _passwordCtrl,
          // usernameCtrl: _usernameCtrl,
          // ageCtrl: _ageCtrl,
          // emailCtrl: _emailCtrl
          ),
    );
  }
}
