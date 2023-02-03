import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_set_state/data/network/rest_api_service.dart';
import 'package:todo_set_state/data/storage/local_storage_service.dart';
import 'package:todo_set_state/ui/listing/todo_list_screen.dart';

import '../../data/model/todo.dart';
import '../../data/network/exceptions.dart';

class TodoEditScreen extends StatefulWidget {
  final Todo todo;
  const TodoEditScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  late RestApiService _restApiService;
  late LocalStorageService _localStorageService;
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _deadlineCtrl;
  late String _priorityDropDownValue;
  late DateTime _newDeadline;
  final DateFormat dateFormat = DateFormat('EEEE, dd MMM yyyy');
  late GlobalKey<FormState> _editTodoFormKey;
  bool _isLoading = false;
  bool _isApiError = false;
  bool _isSessionExpired = false;

  @override
  void initState() {
    ///Initialize all variables
    _titleCtrl = TextEditingController(text: widget.todo.title);
    _descriptionCtrl = TextEditingController(text: widget.todo.description);
    _priorityDropDownValue = _assignDropDownPriorityValue(widget.todo.priority);
    _deadlineCtrl =
        TextEditingController(text: dateFormat.format(widget.todo.deadline));
    _newDeadline = widget.todo.deadline;

    _restApiService = RestApiService();
    _localStorageService = LocalStorageService();
    _editTodoFormKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text('Edit Todo'),
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
                          final result = await _localStorageService
                              .updateAuthToken(newAuthToken);
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
                  : Form(
                      key: _editTodoFormKey,
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),

                          /// Title text field
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _titleCtrl,
                              decoration: InputDecoration(
                                label: const Text('Title'),
                                floatingLabelStyle:
                                    const TextStyle(fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Title should not be empty';
                                }
                                return null;
                              },
                            ),
                          ),

                          /// Description text field
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _descriptionCtrl,
                              maxLines: 3,
                              maxLength: 250,
                              decoration: InputDecoration(
                                label: const Text('Description'),
                                floatingLabelStyle:
                                    const TextStyle(fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Description should not be empty';
                                }
                                return null;
                              },
                            ),
                          ),

                          /// Deadline text field
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  context: context,
                                  builder: (context) => _datePicker(context),
                                );
                              },
                              controller: _deadlineCtrl,
                              decoration: InputDecoration(
                                label: const Text('Deadline'),
                                floatingLabelStyle:
                                    const TextStyle(fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Deadline should not be empty';
                                }
                                return null;
                              },
                            ),
                          ),

                          /// Priority dropdown field
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                label: const Text('Priority'),
                                floatingLabelStyle:
                                    const TextStyle(fontSize: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Priority should not be empty';
                                }
                                return null;
                              },
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(10),
                              value: _priorityDropDownValue,
                              items: const [
                                DropdownMenuItem(
                                  value: 'High',
                                  child: Text('High'),
                                ),
                                DropdownMenuItem(
                                  value: 'Medium',
                                  child: Text('Medium'),
                                ),
                                DropdownMenuItem(
                                  value: 'Low',
                                  child: Text('Low'),
                                )
                              ],
                              onChanged: (value) {
                                ///Update selected value from the dropdown.
                                setState(
                                  () {
                                    _priorityDropDownValue = value as String;
                                  },
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[400]),
                              onPressed: () async {
                                try {
                                  ///Validate form
                                  if (_editTodoFormKey.currentState!
                                      .validate()) {
                                    setState(() {
                                      _isLoading = false;
                                    });

                                    ///Get auth token
                                    final authToken = await _localStorageService
                                        .getAuthToken();

                                    ///Call API to update todos.
                                    Todo updatedTodo = Todo(
                                        title: _titleCtrl.text,
                                        description: _descriptionCtrl.text,
                                        id: widget.todo.id,
                                        updatedAt: DateTime.now(),
                                        createdAt: widget.todo.createdAt,
                                        isCompleted: widget.todo.isCompleted,
                                        deadline: _newDeadline,
                                        priority: _priorityDropDownValue ==
                                                "High"
                                            ? Priority.high
                                            : _priorityDropDownValue == "Medium"
                                                ? Priority.medium
                                                : Priority.low);
                                    final isUpdated =
                                        await _restApiService.updateTodo(
                                            token: authToken!,
                                            todo: updatedTodo);
                                    setState(() {
                                      _isLoading = false;
                                    });

                                    if (mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TodoListScreen(),
                                        ),
                                      );
                                    }
                                  }
                                } on UpdateTodoError catch (_) {
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
                              child: const Text('Save Todo'),
                            ),
                          )
                        ],
                      ),
                    ),
    );
  }

  Widget _datePicker(BuildContext context) {
    return SafeArea(
      child: SfDateRangePicker(
        controller: DateRangePickerController(),
        selectionMode: DateRangePickerSelectionMode.single,
        showActionButtons: true,
        onSubmit: (value) {
          ///Once Confirm Date, format date and update controller.
          final selectedDate = DateTime.parse(value.toString());
          _newDeadline = selectedDate;
          _deadlineCtrl.text = dateFormat.format(selectedDate);

          ///Dismiss the bottom sheet.
          Navigator.pop(context);
        },
        confirmText: 'CONFIRM DATE',
        showNavigationArrow: true,
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  ///Helper
  String _assignDropDownPriorityValue(Priority priority) {
    String p;

    switch (priority) {
      case Priority.high:
        p = 'High';
        break;
      case Priority.medium:
        p = 'Medium';
        break;
      case Priority.low:
        p = 'Low';
        break;
      default:
        p = 'Low';
    }
    return p;
  }
}
