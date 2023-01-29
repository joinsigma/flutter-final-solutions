import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/ui/edit/todo_edit_screen.dart';
import 'package:intl/intl.dart';

class TodoDetailScreen extends StatefulWidget {
  const TodoDetailScreen({Key? key}) : super(key: key);

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  DateFormat _dateFormat = DateFormat('EEEE, dd MMM yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Todo Detail'),
        backgroundColor: Colors.red[400],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.delete),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Title'),
            subtitle: Text('Learn Flutter'),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          ListTile(
            title: Text('Description'),
            subtitle: Text(
              'Lorem Ipsum is simply dummy text of the'
              ' printing and typesetting industry',
            ),
            isThreeLine: true,
          ),
          Divider(
            color: Colors.grey[400],
          ),
          ListTile(
            title: Text('Deadline'),
            subtitle: Text(_dateFormat.format(DateTime.now())),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          ListTile(
            title: Text('Status'),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: Chip(
                avatar: Icon(Icons.calendar_today),
                label: Text('Pending'),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          ListTile(
            title: Text('Priority'),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: Chip(
                avatar: Icon(Icons.priority_high),
                label: Text('High'),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          ListTile(
            title: Text('Created At'),
            subtitle: Text(_dateFormat.format(DateTime.now())),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
              icon: const Icon(Icons.check),
              onPressed: () {},
              label: const Text('Mark as Completed'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TodoEditScreen()));
                },
                label: const Text('Edit Todo')),
          ),
        ],
      ),
    );
  }
}
