import 'package:flutter/material.dart';
import 'package:todo_set_state/ui/listing/widgets/empty_todo_display.dart';
import 'package:todo_set_state/ui/listing/widgets/todo_item.dart';
import '../../../data/model/todo.dart';

class TodoListView extends StatefulWidget {
  final List<Todo> todos;
  const TodoListView({Key? key, required this.todos}) : super(key: key);

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return widget.todos.isEmpty ?
        const EmptyTodoDisplay()
        : ListView.builder(
            itemCount: widget.todos.length,
            itemBuilder: (context, index) {
              return TodoItem(todo: widget.todos[index]);
            },
          );
  }
}
