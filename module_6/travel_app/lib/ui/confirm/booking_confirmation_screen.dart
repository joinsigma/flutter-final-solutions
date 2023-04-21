import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:travel_app/ui/confirm/booking_confirm_bloc.dart';
import 'booking_summary_screen.dart';

class BookingConfirmationScreen extends StatefulWidget {
  final String packageId;
  final int pricePerPax;
  const BookingConfirmationScreen(
      {Key? key, required this.packageId, required this.pricePerPax})
      : super(key: key);

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  late BookingConfirmBloc _bookingConfirmBloc;
  late TextEditingController _fNameCtrl;
  late TextEditingController _lNameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _mobileNoCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _dateCtrl;
  late TextEditingController _numPaxCtrl;
  late GlobalKey<FormState> _bookingFormKey;

  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    _bookingConfirmBloc = kiwi.KiwiContainer().resolve<BookingConfirmBloc>();
    _fNameCtrl = TextEditingController();
    _lNameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _mobileNoCtrl = TextEditingController();
    _addressCtrl = TextEditingController();
    _dateCtrl = TextEditingController();
    _numPaxCtrl = TextEditingController();
    _bookingFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _fNameCtrl.dispose();
    _lNameCtrl.dispose();
    _emailCtrl.dispose();
    _mobileNoCtrl.dispose();
    _dateCtrl.dispose();
    _numPaxCtrl.dispose();
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
          title: const Text('Booking Details'),
        ),
        body: BlocConsumer<BookingConfirmBloc, BookingConfirmState>(
            listener: (context, state) {
          if (state is BookingConfirmSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookingSummaryScreen(),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is BookingConfirmLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingConfirmInitial) {
            return Form(
              key: _bookingFormKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _fNameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your first name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lNameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your last name";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _mobileNoCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Mobile number',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your mobile number";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addressCtrl,
                      maxLength: 250,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Billing Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your address";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _numPaxCtrl,
                      decoration: const InputDecoration(
                        labelText: 'No of pax',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter no of pax";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          context: context,
                          builder: (context) => _datepicker(context),
                        );
                      },
                      controller: _dateCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Select dates',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your dates";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_bookingFormKey.currentState!.validate()) {
                            ///Add event to trigger booking
                            _bookingConfirmBloc.add(
                              TriggerBooking(
                                  packageId: widget.packageId,
                                  fName: _fNameCtrl.text,
                                  lName: _lNameCtrl.text,
                                  email: _emailCtrl.text,
                                  mobileNo: _mobileNoCtrl.text,
                                  billingAddress: _addressCtrl.text,
                                  numPax: int.parse(_numPaxCtrl.text),
                                  startDate: _startDate,
                                  endDate: _endDate,
                                  totalPrice: int.parse(_numPaxCtrl.text) *
                                      widget.pricePerPax),
                            );
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            );
          } else {
            ///Todo: Implement better error message.
            return const Text('Error');
          }
        }),
      ),
    );
  }

  Widget _datepicker(BuildContext context) {
    return SafeArea(
      child: SfDateRangePicker(
        enablePastDates: false,
        controller: DateRangePickerController(),
        showActionButtons: true,
        onSubmit: (value) {
          ///if no value selected, pop and return.
          if (value == null) {
            Navigator.pop(context);
            return;
          }
          final date = value as PickerDateRange;

          ///If on of the date is null, initialize text field with empty character
          if (date.startDate == null || date.endDate == null) {
            _dateCtrl.text = '';
          } else {
            String formattedStartDate =
                '${date.startDate?.day}/${value.startDate?.month}/${value.startDate?.year}';
            String formattedEndDate =
                '${value.endDate?.day}/${value.endDate?.month}/${value.endDate?.year}';
            _dateCtrl.text = "$formattedStartDate - $formattedEndDate";

            ///Assign variables
            _startDate = date.startDate!;
            _endDate = date.endDate!;
          }

          Navigator.pop(context);
        },
        confirmText: 'CONFIRM DATES',
        showNavigationArrow: true,

        onCancel: () {
          print('cancelled');
          Navigator.pop(context);
        },
        selectionMode: DateRangePickerSelectionMode.range,

        // confirmText: 'Confirm',
        // cancelText: 'Back',
      ),
    );
  }
}
