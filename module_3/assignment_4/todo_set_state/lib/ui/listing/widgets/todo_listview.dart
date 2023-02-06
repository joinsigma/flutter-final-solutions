import 'package:flutter/material.dart';
import 'package:todo_set_state/ui/listing/widgets/empty_todo_display.dart';
import 'package:todo_set_state/ui/listing/widgets/todo_item.dart';

import '../../../data/data.dart';
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
        // ? Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(
        //           Icons.info_outline,
        //           size: 40,
        //           color: Theme.of(context).primaryColor,
        //         ),
        //         const SizedBox(
        //           height: 10.0,
        //         ),
        //         Text(
        //           'You have no Todos at the moment. \nStart planning now.',
        //           style: TextStyle(color: Theme.of(context).primaryColor),
        //           textAlign: TextAlign.center,
        //         ),
        //       ],
        //     ),
        //   )
        : ListView.builder(
            itemCount: widget.todos.length,
            itemBuilder: (context, index) {
              return TodoItem(todo: widget.todos[index]);
            },
          );
  }
}
