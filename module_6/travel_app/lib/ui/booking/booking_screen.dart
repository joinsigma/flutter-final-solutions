import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/booking/booking_bloc.dart';
import 'package:travel_app/ui/booking/widgets/booking_card.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import '../../data/model/booking_detail.dart';
import '../cancel/cancel_booking_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late BookingBloc _bookingBloc;
  late TabController _tabController;
  @override
  void initState() {
    _bookingBloc = kiwi.KiwiContainer().resolve<BookingBloc>();
    _bookingBloc.add(LoadBookings());
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _bookingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bookingBloc,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 20, bottom: 8.0),
              child: Text(
                'Booking',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            TabBar(controller: _tabController, tabs: const [
              // Tab(
              //   icon: Chip(
              //     label: Text('Active'),
              //   ),
              // ),
              Tab(
                icon: Text(
                  'Active',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              Tab(
                icon: Text(
                  'Past',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              Tab(
                icon: Text(
                  'Cancelled',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ]),
            BlocBuilder<BookingBloc, BookingState>(builder: (context, state) {
              if (state is BookingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BookingLoadSuccess) {
                return Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    ListView(
                      children: _getActiveBookings(state.bookings),
                    ),
                    Text('past'),
                    Text('cancelled'),
                    // ListView(
                    //   children: [
                    //     BookingCard(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     const CancelBookingScreen()));
                    //       },
                    //     ),
                    //     BookingCard(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     const CancelBookingScreen()));
                    //       },
                    //     ),
                    //     BookingCard(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     const CancelBookingScreen()));
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // ListView(
                    //   children: [
                    //     BookingCard(),
                    //     BookingCard(),
                    //     BookingCard(),
                    //   ],
                    // ),
                    // ListView(
                    //   children: [
                    //     BookingCard(),
                    //     BookingCard(),
                    //     BookingCard(),
                    //   ],
                    // ),
                  ]),
                );
              } else {
                ///Todo: Implement better error msg
                return const Text('Error');
              }
            }),
          ],
        ),
      ),
    );
  }

  List<Widget> _getActiveBookings(List<BookingDetail> bookings) {
    List<Widget> b = [];

    for (BookingDetail booking in bookings) {
      ///Standardize date for comparison
      DateTime bookingEndDate = DateTime(
          booking.endDate.year, booking.endDate.month, booking.endDate.day);
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(now.year, now.month, now.day);

      ///Add to list if booking is ACTIVE and end date is later than current date
      if (booking.status == BookingStatus.active &&
          bookingEndDate.isAfter(now)) {
        b.add(
          BookingCard(
            totalPrice: booking.totalPrice.toString(),
            imageUrl: booking.imageUrl!,
            numPax: booking.numPax.toString(),
            packageTitle: booking.packageId,
            date:
                '${booking.startDate.day}/${booking.startDate.month} - ${booking.endDate.day}/${booking.endDate.month}',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CancelBookingScreen()));
            },
          ),
        );
      }
    }
    return b;
  }
}
