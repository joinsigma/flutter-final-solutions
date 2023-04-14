import 'package:flutter/material.dart';

import 'booking_success_screen.dart';

class BookingSummaryScreen extends StatelessWidget {
  const BookingSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Summary'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  height: 150,
                  child: Image.network(
                    'https://a.cdn-hotels.com/gdcs/production9/d679/a9ebceb6-4e24-48fb-9ad6-16572c9576aa.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        color: Color(0xFF475467),
                        child: const Text(
                          'Apartments',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Text(
                        'Perdana Serviced Apartments & Resorts',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Text(
                          '7.4',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                          'Lot 79, Jalan Kuala Melaka, Mukim Padang Matsirat, Pantai Cenang, 07100')
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Check-in',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                Text('Mon, 19 Dec 2022')
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Check-out',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                Text('Tue, 20 Dec 2022')
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Guests',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                Text('2 adults')
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Spacer(),
                Text(
                  'RM 350',
                  style: TextStyle(
                      color: Color(0xFFF04438),
                      decoration: TextDecoration.lineThrough),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'RM 300',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Divider(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookingSuccessScreen()));
                },
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
