import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/common/widgets/network_error_display.dart';
import 'package:flutter_todo_bloc/ui/detail/bloc/todo_detail_bloc.dart';
import 'package:flutter_todo_bloc/ui/detail/bloc/todo_detail_event.dart';
import 'package:flutter_todo_bloc/ui/detail/bloc/todo_detail_state.dart';
import 'package:intl/intl.dart';

import '../../data/model/todo.dart';
import '../../data/network/exceptions.dart';
import '../../data/network/rest_api_service.dart';
import '../common/widgets/api_error_display.dart';
import '../common/widgets/loading_indicator.dart';
import '../common/widgets/login_redirect_display.dart';
import '../edit/todo_edit_screen.dart';
import '../listing/todo_list_screen.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class TodoDetailScreen extends StatefulWidget {
  final Todo todo;
  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  late TodoDetailBloc _todoDetailBloc;
  final DateFormat _dateFormat = DateFormat('EEEE, dd MMMM yyyy');
  late RestApiService _restApiService;
  bool _isApiError = false;
  bool _isSessionExpired = false;
  bool _isLoading = false;

  @override
  void initState() {
    _todoDetailBloc = kiwi.KiwiContainer().resolve<TodoDetailBloc>();
    _restApiService = RestApiService();
    super.initState();
  }

  @override
  void dispose() {
    _todoDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _todoDetailBloc,
      child: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: const Text('Todo Detail'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Confirmation'),
                          content: const Text(
                              'Are you sure you want to delete this todo ?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  _todoDetailBloc
                                      .add(DeleteTodo(id: widget.todo.id));
                                },
                                child: const Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                          ],
                        );
                      });
                },
                child: const Icon(Icons.delete),
              ),
            )
          ],
        ),
        body: BlocConsumer<TodoDetailBloc, TodoDetailState>(
            listener: (context, state) {
          if (state is TodoDetailSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TodoListScreen(),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is TodoDetailLoading) {
            return const LoadingIndicator();
          }
          if (state is TodoDetailInitial) {
            return ListView(
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
                    )),
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
                  title: const Text('Created At'),
                  subtitle: Text(_dateFormat.format(widget.todo.createdAt)),
                ),
                Divider(
                  color: Colors.grey[400],
                ),
                ListTile(
                  title: const Text('Updated At'),
                  subtitle: Text(_dateFormat.format(widget.todo.updatedAt)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ///Send false value to the server. Todos will become pending
                      if (widget.todo.isCompleted) {
                        _todoDetailBloc.add(UpdateTodoStatus(
                            id: widget.todo.id, isCompleted: false));
                      }

                      ///Send true value to the server. Todos will become completed
                      else {
                        _todoDetailBloc.add(UpdateTodoStatus(
                            id: widget.todo.id, isCompleted: true));
                      }
                    },
                    icon: widget.todo.isCompleted
                        ? const Icon(Icons.close)
                        : const Icon(Icons.check),
                    label: widget.todo.isCompleted
                        ? const Text('Mark as Pending')
                        : const Text('Mark as Completed'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoEditScreen(
                            todo: widget.todo,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Todo'),
                  ),
                )
              ],
            );
          } else if (state is TodoDetailFailure) {
            if (state.isNetworkError) {
              return const NetworkErrorDisplay();
            } else if (state.isSessionExpired) {
              return const LoginRedirectDisplay();
            } else if (state.isApiError) {
              return const ApiErrorDisplay();
            }
          }
          return Container();
        }),
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
}
