import 'package:flutter/material.dart';

import 'booking_summary_screen.dart';

class BookingConfirmationScreen extends StatefulWidget {
  const BookingConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Booking Details'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Mobile number',
                ),
              ),
              TextField(
                controller: TextEditingController(text: 'Malaysia'),
                decoration: const InputDecoration(
                  labelText: 'Country',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: '1'),
                decoration: const InputDecoration(
                  labelText: 'No of pax',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BookingSummaryScreen()));
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
