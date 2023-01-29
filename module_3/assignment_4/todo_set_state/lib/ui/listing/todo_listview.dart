import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/listing/todo_item.dart';
import 'package:flutter_todo_bloc/ui/listing/todo_list_bloc.dart';

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
        itemBuilder: (context,index){
          return TodoItem();
        });
    // return ListView.separated(
    //   itemCount: todos.length,
    //   itemBuilder: (context, index) {
    //     return GestureDetector(
    //       onLongPress: () {
    //         showDialog(
    //           context: context,
    //           builder: (BuildContext context) {
    //             return AlertDialog(
    //               title: const Text('Delete this task ?'),
    //               content: Text('Description'),
    //               actions: [
    //                 TextButton(
    //                     onPressed: () {
    //                       //Todo: implement add Delete even to todolistbloc
    //                     },
    //                     child: const Text('Yes')),
    //                 TextButton(
    //                   onPressed: () {
    //                     Navigator.pop(context);
    //                   },
    //                   child: const Text('No'),
    //                 )
    //               ],
    //             );
    //           },
    //         );
    //       },
    //       onTap: () {
    //         showModalBottomSheet(
    //             context: context,
    //             builder: (context) {
    //               return const Text('Delete');
    //             });
    //       },
    //       child: CheckboxListTile(
    //         title: Text(
    //           'Title'!,
    //           style: const TextStyle(
    //               decoration:
    //                   true ? TextDecoration.lineThrough : TextDecoration.none),
    //         ),
    //         subtitle: Text('Description'),
    //         value: true,
    //         onChanged: (bool? value) {},
    //       ),
    //     );
    //   },
    //   separatorBuilder: (BuildContext context, int index) {
    //     return const Divider();
    //   },
    // );
  }
}
