import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_set_state/data/network/rest_api_service.dart';
import 'package:todo_set_state/data/storage/local_storage_service.dart';
import 'package:todo_set_state/ui/listing/todo_list_screen.dart';

import '../../data/model/todo.dart';
import '../../data/network/exceptions.dart';
import '../edit/todo_edit_screen.dart';

class TodoDetailScreen extends StatefulWidget {
  final Todo todo;
  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  late RestApiService _restApiService;
  late LocalStorageService _localStorageService;
  final DateFormat _dateFormat = DateFormat('EEEE, dd MMM yyyy');
  bool _isLoading = false;
  bool _isSessionExpired = false;
  bool _isApiError = false;
  bool _isMarkCompleted = false;

  ///Todo: Find explanation for this.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _restApiService = RestApiService();
    _localStorageService = LocalStorageService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: const Text('Todo Detail'),
        backgroundColor: Colors.red[400],
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () async {
                showDialog(
                  context: _scaffoldKey.currentContext!,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete Confirmation'),
                      content: const Text(
                          'Are you sure you want to delete this todo ?'),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            try {
                              Navigator.pop(context);
                              setState(() {
                                _isLoading = true;
                              });
                              final authToken =
                                  await _localStorageService.getAuthToken();
                              final result = await _restApiService.deleteTodo(
                                  token: authToken!, id: widget.todo.id);
                              print(result);
                              if (!mounted) return;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TodoListScreen(),
                                ),
                              );
                            } on NotAuthorizedError catch (_) {
                              setState(() {
                                _isLoading = false;
                                _isSessionExpired = true;
                              });
                            } on DeleteTodoError catch (_) {
                              setState(() {
                                _isLoading = false;
                                _isApiError = true;
                              });
                            }
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: _isApiError
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Error communicating with server. Please try again later',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : _isSessionExpired
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Session expired, please refresh.'),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          print('here');
                          ///Get Refresh Token and refresh session via API Service.
                          final refreshToken =
                              await _localStorageService.getRefreshToken();
                          final newAuthToken = await _restApiService
                              .refreshSession(refreshToken!);
                          ///Save new Auth Token
                          final result = await _localStorageService.updateAuthToken(newAuthToken);
                          setState(() {
                            _isLoading = false;
                            _isSessionExpired = false;
                          });
                        },
                        child: const Text('Refresh'),
                      )
                    ],
                  ),
                )
              : _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
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
                          subtitle:
                              Text(_dateFormat.format(widget.todo.deadline)),
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
                          ),
                        ),
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
                          subtitle: Text(_dateFormat.format(DateTime.now())),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 100.0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400]),
                            // icon: _isMarkCompleted
                            icon: widget.todo.isCompleted
                                ? const Icon(Icons.close)
                                : const Icon(Icons.check),
                            onPressed: () async {
                              try {
                                final authToken =
                                    await _localStorageService.getAuthToken();

                                ///If true, call API to update todos isCompleted field as false.
                                // if(_isMarkCompleted){
                                if (widget.todo.isCompleted) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final result =
                                      await _restApiService.updateTodoStatus(
                                          token: authToken!,
                                          id: widget.todo.id,
                                          isCompleted: false);
                                }

                                ///If false, call API to update todos isCompleted field as true
                                else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final result =
                                      await _restApiService.updateTodoStatus(
                                          token: authToken!,
                                          id: widget.todo.id,
                                          isCompleted: true);
                                }
                                if (mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TodoListScreen(),
                                    ),
                                  );
                                }
                              } on UpdateTodoError catch (e) {
                                setState(() {
                                  _isLoading = false;
                                  _isApiError = true;
                                });
                              } on NotAuthorizedError catch (e) {
                                setState(() {
                                  _isLoading = false;
                                  _isSessionExpired = true;
                                });
                              }
                            },
                            // label: _isMarkCompleted
                            label: widget.todo.isCompleted
                                ? const Text('Mark as Pending')
                                : const Text('Mark as Completed'),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 100.0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400]),
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TodoEditScreen(),
                                ),
                              );
                            },
                            label: const Text('Edit Todo'),
                          ),
                        ),
                      ],
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
}
