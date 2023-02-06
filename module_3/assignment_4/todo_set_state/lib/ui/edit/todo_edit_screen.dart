import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_set_state/data/network/rest_api_service.dart';
import 'package:todo_set_state/data/storage/local_storage_service.dart';
import 'package:todo_set_state/ui/common/widgets/api_error_display.dart';
import 'package:todo_set_state/ui/common/helpers.dart';
import 'package:todo_set_state/ui/common/widgets/loading_indicator.dart';
import 'package:todo_set_state/ui/common/widgets/login_redirect_display.dart';
import 'package:todo_set_state/ui/listing/todo_list_screen.dart';

import '../../data/model/todo.dart';
import '../../data/network/exceptions.dart';

class TodoEditScreen extends StatefulWidget {
  final Todo todo;
  const TodoEditScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> with Helpers {
  late RestApiService _restApiService;
  late LocalStorageService _localStorageService;
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _deadlineCtrl;
  late String _priorityDropDownValue;
  late DateTime _newDeadline;
  late GlobalKey<FormState> _editTodoFormKey;
  bool _isLoading = false;
  bool _isApiError = false;
  bool _isSessionExpired = false;

  @override
  void initState() {
    ///Initialize all variables
    _titleCtrl = TextEditingController(text: widget.todo.title);
    _descriptionCtrl = TextEditingController(text: widget.todo.description);
    _priorityDropDownValue = assignDropDownPriorityValue(widget.todo.priority);
    _deadlineCtrl =
        TextEditingController(text: formatDateToString(widget.todo.deadline));
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
          ? const ApiErrorDisplay()
          : _isSessionExpired
              ? const LoginRedirectDisplay()
              : _isLoading
                  ? const LoadingIndicator()
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

                                    ///Get userId
                                    final uid =
                                        await _localStorageService.getUserId();

                                    ///Call API to update todos.
                                    Todo updatedTodo = Todo(
                                        userId: uid!,
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
          _deadlineCtrl.text = formatDateToString(selectedDate);

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
}
