import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/data/model/booking_detail.dart';
import 'package:travel_app/ui/cancel/cancel_booking_bloc.dart';
import 'package:travel_app/ui/home/home_screen.dart';

import 'cancel_success_screen.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class CancelBookingScreen extends StatefulWidget {
  final BookingDetail bookingDetail;
  const CancelBookingScreen({Key? key, required this.bookingDetail})
      : super(key: key);

  @override
  State<CancelBookingScreen> createState() => _CancelBookingScreenState();
}

class _CancelBookingScreenState extends State<CancelBookingScreen> {
  final DateFormat _dateFormat = DateFormat('dd MMMM yyyy');
  final DateFormat _dateFormat2 = DateFormat('EEE, dd MMMM yyyy');
  late CancelBookingBloc _cancelBookingBloc;

  @override
  void initState() {
    _cancelBookingBloc = kiwi.KiwiContainer().resolve<CancelBookingBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>_cancelBookingBloc,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text('Cancel Booking'),
        ),
        body: BlocConsumer<CancelBookingBloc, CancelBookingState>(
            listener: (context, state) {
          if (state is CancelBookingSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    const CancelSuccessScreen()));
          }
        }, builder: (context, state) {
          if (state is CancelBookingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CancelBookingInitial) {
            return ListView(
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
                          widget.bookingDetail.imageUrl!,
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
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              color: const Color(0xFF475467),
                              child: Text(
                                'ID : ${widget.bookingDetail.id}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.bookingDetail.packageTitle,
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            // Container(
                            //   padding: const EdgeInsets.all(5),
                            //   decoration: BoxDecoration(
                            //       color: Colors.orange,
                            //       borderRadius: BorderRadius.circular(5.0)),
                            //   child: const Text(
                            //     '7.4',
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.bookingDetail.partnerName,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'You have booked this on ${_dateFormat.format(widget.bookingDetail.createdAt)}',
                              style: const TextStyle(color: Colors.grey),
                            )
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
                      Text(_dateFormat2.format(widget.bookingDetail.startDate))
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
                      Text(_dateFormat2.format(widget.bookingDetail.endDate))
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
                        'Guests',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      Text('${widget.bookingDetail.numPax} adults')
                    ],
                  ),
                ),
                const Divider(),
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
                      Text(
                        'RM ${widget.bookingDetail.totalPrice}',
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
                        _cancelBookingBloc.add(TriggerCancelBooking(id: widget.bookingDetail.id));


                      },
                      child: const Text(
                        'Confirm Cancel',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            );
          } else if (state is CancelBookingFailed) {
            ///Todo: Implement better error msg.
            return const Center(
              child: Text('Error'),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
