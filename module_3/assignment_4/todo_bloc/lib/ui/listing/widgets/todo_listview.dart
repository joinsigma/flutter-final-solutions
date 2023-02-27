import 'package:flutter/material.dart';
import 'package:flutter_todo_bloc/ui/listing/widgets/todo_item.dart';

import '../../../data/model/todo.dart';
import 'empty_todo_display.dart';

class TodoListView extends StatelessWidget {
  final List<Todo> todos;
  const TodoListView({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? const EmptyTodoDisplay()
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return TodoItem(
                todo: todos[index],
              );
            },
          );
  }
}
