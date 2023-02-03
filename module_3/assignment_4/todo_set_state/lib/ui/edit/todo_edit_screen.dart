import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TodoEditScreen extends StatefulWidget {
  const TodoEditScreen({Key? key}) : super(key: key);

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _deadlineCtrl;
  late TextEditingController _priorityCtrl;
  String dropDownValue = 'Low';
  @override
  void initState() {
    _titleCtrl = TextEditingController(text: 'Learn Flutter');
    _descriptionCtrl = TextEditingController(text: 'Learn Flutter');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text('Edit Todo'),
      ),
      body: Form(
        child: ListView(
          children: [
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                    label: const Text('Title'),
                    floatingLabelStyle: const TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _descriptionCtrl,
                maxLines: 3,
                maxLength: 250,
                decoration: InputDecoration(
                  label: const Text('Description'),
                  floatingLabelStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     readOnly: true,
            //     onTap: () {
            //       showModalBottomSheet(
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(16)),
            //         context: context,
            //         builder: (context) => _datePicker(context),
            //       );
            //     },
            //     controller: _deadlineCtrl,
            //     decoration: const InputDecoration(
            //       prefixIcon: Icon(Icons.calendar_today),
            //     ),
            //   ),
            //   // child: TextFormField(
            //   //   controller: _descriptionCtrl,
            //   //   decoration: InputDecoration(
            //   //     label: const Text('Deadline'),
            //   //     floatingLabelStyle: const TextStyle(fontSize: 20),
            //   //     border: OutlineInputBorder(
            //   //       borderRadius: BorderRadius.circular(10),
            //   //     ),
            //   //   ),
            //   //   onTap: () {
            //   //     ///Set date
            //   //   },
            //   // ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  label: Text('Priority'),
                  floatingLabelStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                isExpanded: true,
                borderRadius: BorderRadius.circular(10),
                value: dropDownValue,
                items: const [
                  DropdownMenuItem(
                    value: 'High',
                    child: Text('High'),
                  ),
                  DropdownMenuItem(
                    value: 'Medium',
                    child: Text('Medium'),
                  ),
                  DropdownMenuItem(
                    value: 'Low',
                    child: Text('Low'),
                  )
                ],
                onChanged: (value) {
                  setState(
                    () {
                      dropDownValue = value as String;
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400]),
                  onPressed: () {},
                  child: const Text('Save Todo')),
            )
          ],
        ),
      ),
    );
  }

  // Widget _datePicker(BuildContext context) {
  //   return SafeArea(
  //     child: SfDateRangePicker(
  //       controller: DateRangePickerController(),
  //       selectionMode: DateRangePickerSelectionMode.single,
  //       showActionButtons: true,
  //       onSubmit: (value) {
  //         print((value as PickerDateRange).startDate);
  //         String startDate =
  //             '${value.startDate?.day}/${value.startDate?.month}';
  //         String endDate = '${value.endDate?.day}/${value.endDate?.month}';
  //         _deadlineCtrl.text = "$startDate - $endDate";
  //         Navigator.pop(context);
  //       },
  //       confirmText: 'CONFIRM DATES',
  //       showNavigationArrow: true,
  //
  //       onCancel: () {
  //         print('cancelled');
  //         Navigator.pop(context);
  //       },
  //
  //
  //       // confirmText: 'Confirm',
  //       // cancelText: 'Back',
  //     ),
  //   );
  // }
}
