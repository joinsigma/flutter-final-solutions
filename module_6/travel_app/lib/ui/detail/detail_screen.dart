import 'package:flutter/material.dart';

import '../confirm/booking_confirmation_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          '3D2N at Langkawi Island',
          maxLines: 2,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookingConfirmationScreen(),
              ),
            );
          },
          child: const Text(
            'Start Booking',
            style: TextStyle(color: Colors.white),
          ),
        ),
      )),
      body: ListView(
        children: [
          _buildPhotoSection(),

          ///Package title, travel company and review section
          ListTile(
            subtitle: const Text('Flutter Travel & Tours'),
            title: const Text(
              '3D2N at Langkawi Island',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(5.0)),
              child: const Text(
                '7.4',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          ///Details section
          const ListTile(
            subtitle: Text('Price per person'),
            title: Text(
              'RM 300',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.place_outlined),
            title: Text(
                style: TextStyle(fontSize: 13),
                'Lot 79, Jalan Kuala Melaka, Mukim Padang Matsirat, Pantai Cenan, 07100 Malaysia'),
          ),
          const ListTile(
            leading: Icon(Icons.description_outlined),
            title: Text(
              """Discover Langkawi in a 3 day 2 nights vacation getaway.Trips include, eagle feeding, snorkeling, beach party and more. Bring you family and close ones for relaxed island tour.""",
              style: TextStyle(fontSize: 13),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.restaurant),
            title: Text(
              'Inclusive 3 breakfast meals',
              style: TextStyle(fontSize: 13),
            ),
          ),

          ///Description
          const Divider(),
          ExpansionTile(
            title: const Text(
              'Itinerary Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            // subtitle: const Text('Eagle Feeding'),

            ///Remove border
            shape: Border.all(color: Colors.transparent),
            children: const [
              ListTile(
                isThreeLine: true,
                leading: Icon(
                  Icons.place,
                  color: Colors.orangeAccent,
                ),
                title: Text('Day 1 - Dayang Bunting Island'),
                subtitle: Text(
                    'Breakfast at hotel. Island hopping tour around Dayang Bunting Island'),
              ),
              ListTile(
                isThreeLine: true,
                leading: Icon(
                  Icons.place,
                  color: Colors.orangeAccent,
                ),
                title: Text('Day 2 - Dayang Bunting Island'),
                subtitle: Text(
                    'Breakfast at hotel. Island hopping tour around Dayang Bunting Island'),
              ),
            ],
          ),
          const Divider(),

          ///Facilities
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tags',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          _buildTagsSection(),
        ],
      ),
    );
  }

  ///Photo section
  Widget _buildPhotoSection() {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PageView(
            children: [
              Image.network(
                'https://cf.bstatic.com/xdata/images/hotel/max1280x900/288170556.jpg?k=aeeaa7d131685735ce229897f1f1f2f18667e7ef59c558a819d6a18d127979b5&o=&hp=1',
                fit: BoxFit.cover,
              ),
              Image.network(
                'https://cf.bstatic.com/xdata/images/hotel/max1024x768/294906194.jpg?k=999e84336dc751407e0246391844d4466f37173886f969afd63c747743505b17&o=&hp=1',
                fit: BoxFit.cover,
              ),
              Image.network(
                'https://cf.bstatic.com/xdata/images/hotel/max1280x900/375663715.jpg?k=8f6fc16107ce76685c8986208895e9a54ad4fe34277335983019dac5b759742b&o=&hp=1',
                fit: BoxFit.cover,
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30.0)),
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30.0)),
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildBookingInfo() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: Row(
  //           children: [
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text('Start'),
  //                 Text(
  //                   'Mon, 19 Dec',
  //                   style: TextStyle(color: Colors.orange),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(
  //               width: 100,
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text('End'),
  //                 Text(
  //                   'Tue, 20 Dec',
  //                   style: TextStyle(color: Colors.orange),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.only(left: 8.0, top: 8.0),
  //         child: Text('No of guests'),
  //       ),
  //       const Padding(
  //         padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
  //         child: Text(
  //           '3 adults',
  //           style: TextStyle(color: Colors.orange),
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget _buildItineraryDetails() {
  //   return ExpansionTile(
  //     title: const Text(
  //       'Day 1',
  //     ),
  //     subtitle: const Text('Eagle Feeding'),
  //
  //     ///Remove border
  //     shape: Border.all(color: Colors.transparent),
  //     children: const [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 13.0),
  //         child: Text(
  //             'Situated in Pantain Cenang, 1.3km from Cenang beach, Perdana Serviced Appartment & resorts features accomodation with free bikes, free private parknig, an outdoor simming pol and a shared louge. Boasting a shared kitchen, this property also provides guests with a terrace. The property offers car hire and feature a garden and berceue.'),
  //       )
  //     ],
  //   );
  // }

  ///Tags section
  Widget _buildTagsSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Wrap(
        spacing: 5.0,
        children: const [
          Chip(
            backgroundColor: Colors.orangeAccent,
            label: Text(
              'Island Hopping',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Chip(
            backgroundColor: Colors.orangeAccent,
            label: Text(
              'Eagle Feeding',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Chip(
            backgroundColor: Colors.orangeAccent,
            label: Text(
              'Island Tour',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Chip(
            backgroundColor: Colors.orangeAccent,
            label: Text(
              'Pristine Beach',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
