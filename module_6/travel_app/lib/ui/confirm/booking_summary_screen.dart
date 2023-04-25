import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/model/booking_detail.dart';
import 'booking_confirm_bloc.dart';
import 'booking_success_screen.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class BookingSummaryScreen extends StatefulWidget {
  final BookingDetail booking;

  const BookingSummaryScreen({Key? key, required this.booking})
      : super(key: key);

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final DateFormat _dateFormat = DateFormat('EEE, dd MMMM yyyy');
  late BookingConfirmBloc _bookingConfirmBloc;

  @override
  void initState() {
    _bookingConfirmBloc = kiwi.KiwiContainer().resolve<BookingConfirmBloc>();
    _bookingConfirmBloc.add(LoadPackageInfo(widget.booking.packageId));
    super.initState();
  }

  @override
  void dispose() {
    _bookingConfirmBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bookingConfirmBloc,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text('Booking Summary'),
        ),
        body: BlocConsumer<BookingConfirmBloc, BookingConfirmState>(
            listener: (context, state) {
          if (state is BookingConfirmSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BookingSuccessScreen(),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is BookingConfirmLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingConfirmInitial) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 120,
                        child: Image.network(
                          state.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   padding: const EdgeInsets.all(5.0),
                            //   color: Color(0xFF475467),
                            //   child: const Text(
                            //     'Apartments',
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            // ),
                            Text(
                              state.packageTitle,
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              state.packageProvider,
                              style: const TextStyle(
                                // fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),

                            Text(state.packageLocation),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Text(
                                '${state.packageRating}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Check-in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      Text(_dateFormat.format(widget.booking.startDate))
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Check-out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      Text(_dateFormat.format(widget.booking.endDate))
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      Text('${widget.booking.numPax} adults')
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        'RM ${widget.booking.totalPrice}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        _bookingConfirmBloc.add(TriggerBooking(
                            partnerName: widget.booking.partnerName,
                            packageTitle: widget.booking.packageTitle,
                            packageId: widget.booking.packageId,
                            fName: widget.booking.custFirstName,
                            lName: widget.booking.custLastName,
                            email: widget.booking.email,
                            mobileNo: widget.booking.mobileNo,
                            imageUrl: state.imageUrl,
                            billingAddress: widget.booking.billingAddress,
                            numPax: widget.booking.numPax,
                            startDate: widget.booking.startDate,
                            endDate: widget.booking.endDate,
                            totalPrice: widget.booking.totalPrice));
                      },
                      child: const Text(
                        'Confirm Booking',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            );
          } else {
            ///Todo: Implement better error message.
            return const Text('Error');
          }
        }),
      ),
    );
  }
}
