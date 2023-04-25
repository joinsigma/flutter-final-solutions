import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/booking/booking_bloc.dart';
import 'package:travel_app/ui/booking/widgets/booking_card.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import '../../data/model/booking_detail.dart';
import '../cancel/cancel_booking_screen.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  final DateFormat _sDateFormat = DateFormat('dd MMM');
  final DateFormat _eDateFormat = DateFormat('dd MMM yyyy');
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
                final activeBookings = _getActiveBookings(state.bookings);
                final pastBookings = _getPastBookings(state.bookings);
                final cancelledBookings = _getCancelledBookings(state.bookings);
                return Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    ///Active
                    activeBookings.isEmpty
                        ? const Center(
                            child: Text('No active booking at the moment'),
                          )
                        : ListView(
                            children: activeBookings,
                          ),

                    ///Past
                    pastBookings.isEmpty
                        ? const Center(
                            child: Text('No past booking at the moment'),
                          )
                        : ListView(
                            children: pastBookings,
                          ),

                    ///Cancelled
                    cancelledBookings.isEmpty
                        ? const Center(
                            child: Text('No cancelled booking at the moment'),
                          )
                        : ListView(
                            children: cancelledBookings,
                          ),
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

  ///Helper
  List<Widget> _getActiveBookings(List<BookingDetail> bookings) {
    List<Widget> activeBookings = [];

    for (BookingDetail booking in bookings) {
      ///Standardize date for comparison
      DateTime bookingEndDate = DateTime(
          booking.endDate.year, booking.endDate.month, booking.endDate.day);
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(now.year, now.month, now.day);

      ///Add to list if booking is ACTIVE and end date is later than current date
      if (booking.status == BookingStatus.active &&
          bookingEndDate.isAfter(currentDate)) {
        activeBookings.add(
          BookingCard(
            totalPrice: booking.totalPrice.toString(),
            imageUrl: booking.imageUrl!,
            numPax: booking.numPax.toString(),
            packageTitle: booking.packageTitle,
            date:
                '${_sDateFormat.format(booking.startDate)} - ${_eDateFormat.format(booking.endDate)}',
            // date:
            //     '${booking.startDate.day}/${booking.startDate.month} - ${booking.endDate.day}/${booking.endDate.month}',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CancelBookingScreen(
                    bookingDetail: booking,
                  ),
                ),
              );
            },
          ),
        );
      }
    }
    return activeBookings;
  }

  List<Widget> _getPastBookings(List<BookingDetail> bookings) {
    List<Widget> pastBookings = [];

    for (BookingDetail booking in bookings) {
      ///Standardize date for comparison
      DateTime bookingEndDate = DateTime(
          booking.endDate.year, booking.endDate.month, booking.endDate.day);
      DateTime now = DateTime.now();
      DateTime currentDate = DateTime(now.year, now.month, now.day);

      ///Add to list if booking is COMPLETED and current date is later than booking end date.
      if (booking.status == BookingStatus.active &&
          currentDate.isAfter(bookingEndDate)) {
        pastBookings.add(
          BookingCard(
            totalPrice: booking.totalPrice.toString(),
            imageUrl: booking.imageUrl!,
            numPax: booking.numPax.toString(),
            packageTitle: booking.packageTitle,
            date:
                '${_sDateFormat.format(booking.startDate)} - ${_eDateFormat.format(booking.endDate)}',
          ),
        );
      }
    }
    return pastBookings;
  }

  List<Widget> _getCancelledBookings(List<BookingDetail> bookings) {
    List<Widget> cancelledBookings = [];

    for (BookingDetail booking in bookings) {
      ///Add to list if booking is CANCELLED and current date is later than booking end date.
      if (booking.status == BookingStatus.cancelled) {
        cancelledBookings.add(
          BookingCard(
            totalPrice: booking.totalPrice.toString(),
            imageUrl: booking.imageUrl!,
            numPax: booking.numPax.toString(),
            packageTitle: booking.packageTitle,
            date:
                '${_sDateFormat.format(booking.startDate)} - ${_eDateFormat.format(booking.endDate)}',
          ),
        );
      }
    }
    return cancelledBookings;
  }
}
