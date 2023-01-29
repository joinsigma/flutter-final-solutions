import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/ui/listing/todo_item.dart';

import '../../data/data.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return const TodoItem();
      },
    );
  }
}
