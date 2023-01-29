import 'package:flutter/material.dart';

class TodoAddScreen extends StatefulWidget {
  const TodoAddScreen({Key? key}) : super(key: key);

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
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
        title: const Text('Add Todo'),
      ),
      body: Form(
        child: ListView(
          children: [
            const SizedBox(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _descriptionCtrl,
                decoration: InputDecoration(
                  label: const Text('Deadline'),
                  floatingLabelStyle: const TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onTap: () {
                  ///Set date
                },
              ),
            ),
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
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
                onPressed: () {},
                child: const Text('Submit Todo'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
