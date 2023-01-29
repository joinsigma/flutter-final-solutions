import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/ui/add/todo_add_screen.dart';
import 'package:flutter_todo_bloc/ui/listing/todo_listview.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late TextEditingController _todoCtrl;

  @override
  void initState() {
    _todoCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text('My Todos'),
      ),
      body: const TodoListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TodoAddScreen(),
            ),
          );
        },
      ),
    );
  }
}
