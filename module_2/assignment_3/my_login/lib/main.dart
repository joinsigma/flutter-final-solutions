import 'package:flutter/material.dart';
import 'package:my_login/commons/styles.dart';
import 'package:my_login/otp_auth_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My Login',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header text
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      // Login email field
                      TextFormField(
                        decoration: kLoginTextFieldStyle.copyWith(
                          hintText: 'Enter your email here',
                          prefixIcon: const Icon(Icons.email_outlined),
                          label: const Text('Email'),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Email should not be empty';
                          }
                          return null;
                        }),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 15.0),

                      // Password field
                      TextFormField(
                        decoration: kLoginTextFieldStyle.copyWith(
                          hintText: 'Enter your password here',
                          prefixIcon: const Icon(Icons.lock_open_outlined),
                          label: const Text('Password'),
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pasword cannot be empty';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),

                      const SizedBox(height: 15.0),

                      // Sign in button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.login),
                          label: const Text('Sign in'),
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const OTPAuthScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ),

                      const SizedBox(height: 15.0),

                      // Divider
                      const Divider(color: Colors.black),

                      const SizedBox(height: 5.0),

                      const Center(
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12.0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 5.0),

                      // Social Login Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            foregroundColor: Colors.white,
                            visualDensity: VisualDensity.comfortable,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.facebook,
                              ),
                              Text(
                                'Sign in with Facebook',
                                style: TextStyle(fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 5.0),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            visualDensity: VisualDensity.comfortable,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.g_mobiledata,
                                size: 28.0,
                              ),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
