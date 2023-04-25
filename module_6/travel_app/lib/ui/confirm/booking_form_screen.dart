import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:travel_app/ui/confirm/booking_confirm_bloc.dart';
import '../../data/model/booking_detail.dart';
import 'booking_summary_screen.dart';

class BookingFormScreen extends StatefulWidget {
  final String packageId;
  final int pricePerPax;
  final String packageTitle;
  final String partnerName;
  const BookingFormScreen(
      {Key? key,
      required this.packageId,
      required this.packageTitle,
      required this.partnerName,
      required this.pricePerPax})
      : super(key: key);

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
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
                    builder: (context) => _datePicker(context),
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
                      final bookingDetail = BookingDetail(
                          id: '1',
                          userId: '1',
                          partnerName: widget.partnerName,
                          packageId: widget.packageId,
                          packageTitle: widget.packageTitle,
                          custFirstName: _fNameCtrl.text,
                          custLastName: _lNameCtrl.text,
                          email: _emailCtrl.text,
                          mobileNo: _mobileNoCtrl.text,
                          billingAddress: _addressCtrl.text,
                          numPax: int.parse(_numPaxCtrl.text),
                          startDate: _startDate,
                          endDate: _endDate,
                          createdAt: DateTime.now(),
                          totalPrice:
                              int.parse(_numPaxCtrl.text) * widget.pricePerPax);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingSummaryScreen(
                            booking: bookingDetail,
                          ),
                        ),
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
      ),
    );
  }

  Widget _datePicker(BuildContext context) {
    return SafeArea(
      child: SfDateRangePicker(
        enablePastDates: true,
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
