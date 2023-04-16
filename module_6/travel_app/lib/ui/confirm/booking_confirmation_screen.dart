import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'booking_summary_screen.dart';

class BookingConfirmationScreen extends StatefulWidget {
  const BookingConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  late TextEditingController _fNameCtrl;
  late TextEditingController _lNameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _mobileNoCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _dateCtrl;
  late TextEditingController _numPaxCtrl;
  late GlobalKey<FormState> _bookingFormKey;

  @override
  void initState() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Booking Details'),
      ),
      body: Form(
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
                      print('valid');
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const BookingSummaryScreen(),
                    //   ),
                    // );
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
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
