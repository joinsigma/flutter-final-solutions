import 'package:flutter/material.dart';
import 'package:my_login/commons/styles.dart';
import 'package:pinput/pinput.dart';

class OTPAuthScreen extends StatefulWidget {
  const OTPAuthScreen({super.key});

  @override
  State<OTPAuthScreen> createState() => _OTPAuthScreenState();
}

class _OTPAuthScreenState extends State<OTPAuthScreen> {
  final pinController = TextEditingController();
  final pinFocusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Authentication'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 36.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Text
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20.0),

              // Instruction text
              const Text(
                'Enter the code sent to the email.',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 20.0),

              // Pinput
              Pinput(
                length: 4,
                controller: pinController,
                focusNode: pinFocusNode,
                defaultPinTheme: defaultPinTheme,
              ),

              const SizedBox(height: 60.0),

              // Didnt receive code
              Text(
                "Didn't receive code?",
                style: TextStyle(color: Colors.blue[900]),
              ),

              const SizedBox(height: 10.0),

              Text(
                "Resend",
                style: TextStyle(
                  color: Colors.blue[900],
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
