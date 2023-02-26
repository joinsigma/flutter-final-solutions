import 'package:flutter/material.dart';
import '../../../data/model/todo.dart';
import '../../detail/todo_detail_screen.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0, left: 5.0, top: 5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoDetailScreen(todo: todo),
            ),
          );
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
                        todo.title,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(
                        todo.description,
                        style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Wrap(
                        children: [
                          _assignStatusChip(todo.priority),
                          _assignTimelineStatusChip(todo.deadline)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              todo.isCompleted
                  ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  ///Helper
  Widget _assignStatusChip(Priority priority) {
    Widget p;

    switch (priority) {
      case Priority.high:
        p = Chip(
          backgroundColor: Colors.purple[50],
          avatar: const Icon(
            Icons.priority_high,
            color: Colors.purple,
          ),
          label: const Text(
            'High',
            style: TextStyle(color: Colors.purple),
          ),
        );
        break;
      case Priority.medium:
        p = Chip(
          backgroundColor: Colors.blue[50],
          avatar: const Icon(
            Icons.low_priority,
            color: Colors.blue,
          ),
          label: const Text(
            'Medium',
            style: TextStyle(color: Colors.blue),
          ),
        );
        break;
      case Priority.low:
        p = Chip(
          backgroundColor: Colors.brown[50],
          avatar: const Icon(
            Icons.low_priority,
            color: Colors.brown,
          ),
          label: const Text(
            'Low',
            style: TextStyle(color: Colors.brown),
          ),
        );
        break;
      default:
        p = Chip(
          backgroundColor: Colors.brown[50],
          avatar: const Icon(
            Icons.low_priority,
            color: Colors.brown,
          ),
          label: const Text(
            'Low',
            style: TextStyle(color: Colors.brown),
          ),
        );
    }
    return p;
  }

  Widget _assignTimelineStatusChip(DateTime deadline) {
    int deadlineEpoch = deadline.millisecondsSinceEpoch;
    DateTime now = DateTime.now();

    int todayEpoch =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    if (deadlineEpoch == todayEpoch) {
      ///Deadline today
      return Chip(
        backgroundColor: Colors.teal[50],
        avatar: const Icon(
          Icons.calendar_today,
          color: Colors.teal,
        ),
        label: const Text(
          'Today',
          style: TextStyle(color: Colors.teal),
        ),
      );
    } else if (deadlineEpoch > todayEpoch) {
      ///Deadline upcoming
      return Chip(
        backgroundColor: Colors.orange[50],
        avatar: const Icon(
          Icons.calendar_today,
          color: Colors.orange,
        ),
        label: const Text(
          'Upcoming',
          style: TextStyle(color: Colors.orange),
        ),
      );
    } else {
      ///Deadline delayed
      return Chip(
        backgroundColor: Colors.red[50],
        avatar: const Icon(
          Icons.calendar_today,
          color: Colors.red,
        ),
        label: const Text(
          'Delayed',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
  }
}
