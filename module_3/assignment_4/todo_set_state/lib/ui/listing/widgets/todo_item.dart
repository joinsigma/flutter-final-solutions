import 'package:flutter/material.dart';
import '../../../data/model/todo.dart';
import '../../detail/todo_detail_screen.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  TodoItem({Key? key, required this.todo}) : super(key: key);
  final now = DateTime.now();
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
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Wrap(
                        children: [
                          _assignStatusChip(todo.priority),
                          const SizedBox(
                            width: 8,
                          ),
                          _assignTimelineStatusChip(todo.deadline),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (todo.isCompleted)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                )
            ],
          ),
        ),
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

  ///Compare today\'s date against task deadline and return the right status.
  Widget _assignTimelineStatusChip(DateTime deadline) {
    int deadlineEpoch = deadline.millisecondsSinceEpoch;
    DateTime now = DateTime.now();
    int todayEpoch =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    if (deadlineEpoch == todayEpoch) {
      return Chip(
        avatar: const Icon(
          Icons.calendar_today,
          color: Colors.teal,
        ),
        label: const Text(
          'Today',
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: Colors.teal[50],
      );
    } else if (deadlineEpoch > todayEpoch) {
      return Chip(
        avatar: const Icon(
          Icons.calendar_today,
          color: Colors.orange,
        ),
        label: const Text(
          'Upcoming',
          style: TextStyle(color: Colors.orange),
        ),
        backgroundColor: Colors.orange[50],
      );
    } else {
      return Chip(
        avatar: const Icon(
          Icons.calendar_today,
          color: Colors.red,
        ),
        label: const Text(
          'Delayed',
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.red[100],
      );
    }
  }
}
