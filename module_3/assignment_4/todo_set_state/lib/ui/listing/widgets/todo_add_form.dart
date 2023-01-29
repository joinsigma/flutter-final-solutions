import 'package:flutter/material.dart';

class TodoAddForm extends StatefulWidget {
  const TodoAddForm({Key? key}) : super(key: key);

  @override
  State<TodoAddForm> createState() => _TodoAddFormState();
}

class _TodoAddFormState extends State<TodoAddForm> {
  late TextEditingController _titleCtrl;

  @override
  void initState() {
    _titleCtrl = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          const Text('Add new Todo'),
          TextField(
            controller: _titleCtrl,
            decoration: const InputDecoration(
              label: Text('Write something'),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
            ),
            onPressed: () {
              ///Todo: Add Todo
              // _todoListBloc.add(
              //   AddNewTodo(_todoCtrl.text),
              // );
              // Navigator.pop(context);
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
