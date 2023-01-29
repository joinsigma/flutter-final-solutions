import 'package:flutter/material.dart';

import '../detail/todo_detail_screen.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:
          (context) => TodoDetailScreen()
          ));
        },
        child: Card(
          color: Colors.grey[100],
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Learn Flutter',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Lorem Ipsum is simply dummy text of the'
                        ' printing and typesetting industry',
                        overflow: TextOverflow.ellipsis,
                      ),
                      Wrap(
                        children: [
                          Chip(
                            avatar: Icon(
                              Icons.priority_high,
                              color: Colors.purple,
                            ),
                            label: Text(
                              'High',
                              style: TextStyle(color: Colors.purple),
                            ),
                            backgroundColor: Colors.purple[50],
                          ),
                          Chip(
                            avatar: Icon(
                              Icons.low_priority,
                              color: Colors.blue,
                            ),
                            label: Text(
                              'Medium',
                              style: TextStyle(color: Colors.blue),
                            ),
                            backgroundColor: Colors.blue[50],
                          ),
                          Chip(
                            avatar: Icon(
                              Icons.low_priority,
                              color: Colors.brown,
                            ),
                            label: Text(
                              'Low',
                              style: TextStyle(color: Colors.brown),
                            ),
                            backgroundColor: Colors.brown[50],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Chip(
                            avatar: Icon(
                              Icons.calendar_today,
                              color: Colors.teal,
                            ),
                            label: Text(
                              'Today',
                              style: TextStyle(color: Colors.teal),
                            ),
                            backgroundColor: Colors.teal[50],
                          ),
                          Chip(
                            avatar: Icon(
                              Icons.calendar_today,
                              color: Colors.orange,
                            ),
                            label: Text(
                              'Upcoming',
                              style: TextStyle(color: Colors.orange),
                            ),
                            backgroundColor: Colors.orange[50],
                          ),
                          Chip(
                            avatar: Icon(
                              Icons.calendar_today,
                              color: Colors.red,
                            ),
                            label: Text(
                              'Delayed',
                              style: TextStyle(color: Colors.red),
                            ),
                            backgroundColor: Colors.red[100],
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Chip(
                      //       avatar: Icon(
                      //         Icons.priority_high,
                      //         color: Colors.red,
                      //       ),
                      //       label: Text(
                      //         'High',
                      //         style: TextStyle(color: Colors.red),
                      //       ),
                      //       backgroundColor: Colors.red[100],
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     Chip(
                      //       avatar: Icon(
                      //         Icons.calendar_today,
                      //         color: Colors.teal,
                      //       ),
                      //       label: Text(
                      //         'Today',
                      //         style: TextStyle(color: Colors.teal),
                      //       ),
                      //       backgroundColor: Colors.teal[50],
                      //     ),
                      //     Chip(
                      //       avatar: Icon(
                      //         Icons.calendar_today,
                      //         color: Colors.orange,
                      //       ),
                      //       label: Text(
                      //         'Upcoming',
                      //         style: TextStyle(color: Colors.orange),
                      //       ),
                      //       backgroundColor: Colors.orange[50],
                      //     ),
                      //     Chip(
                      //       avatar: Icon(
                      //         Icons.calendar_today,
                      //         color: Colors.red,
                      //       ),
                      //       label: Text(
                      //         'Delayed',
                      //         style: TextStyle(color: Colors.red),
                      //       ),
                      //       backgroundColor: Colors.red[100],
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              Checkbox(value: false, onChanged: (value) {}),
            ],
          ),
        ),
      ),
    );
  }
}
