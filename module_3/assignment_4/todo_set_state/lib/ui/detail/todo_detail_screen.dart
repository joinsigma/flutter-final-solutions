import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/model/todo.dart';
import '../edit/todo_edit_screen.dart';

class TodoDetailScreen extends StatefulWidget {
  final Todo todo;
  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final DateFormat _dateFormat = DateFormat('EEEE, dd MMM yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: const Text('Todo Detail'),
        backgroundColor: Colors.red[400],
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.delete),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Title'),
            subtitle: Text(widget.todo.title),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          ListTile(
            title: const Text('Description'),
            subtitle: Text(widget.todo.description),
            isThreeLine: true,
          ),
          Divider(
            color: Colors.grey[400],
          ),
          ListTile(
            title: const Text('Deadline'),
            subtitle: Text(_dateFormat.format(widget.todo.deadline)),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          ListTile(
            title: const Text('Status'),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: widget.todo.isCompleted
                  ? Chip(
                      backgroundColor: Colors.green[100],
                      avatar: const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      label: const Text(
                        'Completed',
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  : Chip(
                      backgroundColor: Colors.orange[100],
                      avatar: const Icon(
                        Icons.pending_outlined,
                        color: Colors.orange,
                      ),
                      label: const Text(
                        'Pending',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          ListTile(
            title: const Text('Priority'),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: _assignStatusChip(widget.todo.priority),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[400]),
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoEditScreen(),
                  ),
                );
              },
              label: const Text('Edit Todo'),
            ),
          ),
        ],
      ),
    );
  }

  ///Compare task priority and return the right status.
  Widget _assignStatusChip(Priority priority) {
    Widget p;

    switch (priority) {
      case Priority.high:
        p = Chip(
          avatar: const Icon(
            Icons.priority_high,
            color: Colors.purple,
          ),
          label: const Text(
            'High',
            style: TextStyle(color: Colors.purple),
          ),
          backgroundColor: Colors.purple[50],
        );
        break;
      case Priority.medium:
        p = Chip(
          avatar: const Icon(
            Icons.low_priority,
            color: Colors.blue,
          ),
          label: const Text(
            'Medium',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.blue[50],
        );
        break;
      case Priority.low:
        p = Chip(
          avatar: const Icon(
            Icons.low_priority,
            color: Colors.brown,
          ),
          label: const Text(
            'Low',
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.brown[50],
        );
        break;
      default:
        p = Chip(
          avatar: const Icon(
            Icons.low_priority,
            color: Colors.brown,
          ),
          label: const Text(
            'Low',
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.brown[50],
        );
    }
    return p;
  }
}
