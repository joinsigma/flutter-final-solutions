import 'package:flutter/material.dart';

import '../../listing/todo_list_screen.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final String? errorMsg;
  const LoginForm(
      {Key? key,
      required this.passwordCtrl,
      required this.emailCtrl,
      this.errorMsg})
      : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        TextField(
          controller: widget.emailCtrl,
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            label: Text('Email'),
          ),
        ),
        TextField(
          controller: widget.passwordCtrl,
          obscureText: true,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock),
            label: Text('Password'),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
            onPressed: () async {
              // BlocProvider.of<LoginBloc>(context).add(
              //   TriggerLogin(
              //       username: widget.emailCtrl.text,
              //       password: widget.passwordCtrl.text),
              // );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoListScreen(),
                ),
              );
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
        widget.errorMsg == null
            ? Container()
            : Text(
                widget.errorMsg!,
                style: const TextStyle(color: Colors.red),
              )
      ],
    );
  }
}
