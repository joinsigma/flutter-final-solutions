import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:todo_set_state/ui/common/widgets/api_error_display.dart';
import 'package:todo_set_state/ui/common/widgets/loading_indicator.dart';
import 'package:todo_set_state/ui/common/widgets/login_redirect_display.dart';
import 'package:todo_set_state/ui/listing/todo_list_screen.dart';

import '../../data/model/todo.dart';
import '../../data/network/exceptions.dart';
import '../../data/network/rest_api_service.dart';
import '../../data/storage/local_storage_service.dart';
import '../common/helpers.dart';

class TodoAddScreen extends StatefulWidget {
  const TodoAddScreen({Key? key}) : super(key: key);

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> with Helper {
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _deadlineCtrl;
  late DateTime _deadline;
  late RestApiService _restApiService;
  late LocalStorageService _localStorageService;
  String _priorityDropDownValue = "Low";
  late GlobalKey<FormState> _addTodoFormKey;
  bool _isLoading = false;
  bool _isApiError = false;
  bool _isSessionExpired = false;

  @override
  void initState() {
    ///Initialize all variables
    _titleCtrl = TextEditingController();
    _descriptionCtrl = TextEditingController();
    _deadlineCtrl = TextEditingController();
    _restApiService = RestApiService();
    _localStorageService = LocalStorageService();
    _addTodoFormKey = GlobalKey<FormState>();
    _deadline = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text('Add Todo'),
      ),
      body: _isApiError
          ? const ApiErrorDisplay()
          : _isSessionExpired
              ? const LoginRedirectDisplay()
              : _isLoading
                  ? const LoadingIndicator()
                  : Form(
                      key: _addTodoFormKey,
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
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
                                  if (_addTodoFormKey.currentState!
                                      .validate()) {
                                    ///Update state to be Loading
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    ///Get Auth token
                                    final authToken = await _localStorageService
                                        .getAuthToken();

                                    ///Get user Id
                                    final uid =
                                        await _localStorageService.getUserId();

                                    ///create Todos object
                                    final todo = Todo(
                                        id: "1",
                                        userId: uid!,
                                        priority: convertStringToPriority(
                                            _priorityDropDownValue),
                                        deadline: _deadline,
                                        isCompleted: false,
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                        description: _descriptionCtrl.text,
                                        title: _titleCtrl.text);

                                    ///Call API to add Todos
                                    final result =
                                        await _restApiService.addNewTodo(
                                            token: authToken!, todo: todo);

                                    ///Update Loading state
                                    setState(() {
                                      _isLoading = false;
                                    });

                                    ///Navigate to TodoListScreen.
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
                                } on AddTodoError catch (_) {
                                  setState(() {
                                    _isLoading = false;
                                    _isApiError = true;
                                  });
                                } on NotAuthorizedError catch (_) {
                                  setState(() {
                                    _isLoading = false;
                                    _isSessionExpired = true;
                                  });
                                } on UidErrorException catch (_) {
                                  ///If unsuccessful update error message for display
                                  setState(() {
                                    _isLoading = false;
                                    _isApiError = true;
                                  });
                                }
                              },
                              child: const Text('Submit Todo'),
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
          _deadline = selectedDate;
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
