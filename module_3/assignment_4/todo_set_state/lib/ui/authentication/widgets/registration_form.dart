import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/ui/listing/todo_list_screen.dart';

class RegistrationForm extends StatefulWidget {
  final TextEditingController usernameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController ageCtrl;
  final TextEditingController passwordCtrl;
  final String? errorMsg;
  const RegistrationForm(
      {Key? key,
      required this.passwordCtrl,
      required this.usernameCtrl,
      required this.ageCtrl,
      required this.emailCtrl,
      this.errorMsg})
      : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Register to Todoist",
          style: TextStyle(fontSize: 30.0),
        ),
        const SizedBox(
          height: 30.0,
        ),
        TextField(
          controller: widget.usernameCtrl,
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            label: Text('Username'),
          ),
        ),
        TextField(
          controller: widget.emailCtrl,
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            label: Text('Email'),
          ),
        ),
        TextField(
          controller: widget.ageCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            icon: Icon(Icons.numbers),
            label: Text('Age'),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoListScreen(),
                ),
              );

              ///Todo: Convert to set state approach.
              // BlocProvider.of<RegistrationBloc>(context).add(
              //   TriggerRegistration(
              //     username: widget.usernameCtrl.text,
              //     password: widget.passwordCtrl.text,
              //     email: widget.emailCtrl.text,
              //     age: int.parse(widget.ageCtrl.text),
              //   ),
              // );
            },
            child: const Text('Register'),
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
