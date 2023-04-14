import 'package:flutter/material.dart';

import '../main_screen.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.airplane_ticket,
              color: Colors.orange,
              size: 30.0,
            ),
            Text(
              'Booking Succesful',
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 200.0,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(initialPageIndex: 0),
                    ),
                  );
                },
                child: const Text('Keep Exploring'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
