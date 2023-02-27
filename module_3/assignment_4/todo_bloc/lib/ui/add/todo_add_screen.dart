import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../data/model/todo.dart';
import '../../data/network/exceptions.dart';
import '../../data/network/rest_api_service.dart';
import '../../data/storage/local_storage_service.dart';
import '../common/widgets/api_error_display.dart';
import '../common/widgets/loading_indicator.dart';
import '../common/widgets/login_redirect_display.dart';
import '../listing/todo_list_screen.dart';

class TodoAddScreen extends StatefulWidget {
  const TodoAddScreen({Key? key}) : super(key: key);

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  late LocalStorageService _localStorageService;
  late RestApiService _restApiService;
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _deadlineCtrl;
  late String _priorityDropdownValue;
  late DateTime _newDeadline;
  late GlobalKey<FormState> _addTodoFormKey;
  bool _isApiError = false;
  bool _isSessionExpired = false;
  bool _isLoading = false;

  @override
  void initState() {
    _localStorageService = LocalStorageService();
    _restApiService = RestApiService();
    _titleCtrl = TextEditingController();
    _descriptionCtrl = TextEditingController();
    _deadlineCtrl = TextEditingController();
    _priorityDropdownValue = 'Low';
    _newDeadline = DateTime.now();
    _addTodoFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
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
                                    const TextStyle(fontSize: 20.0),
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
                                    const TextStyle(fontSize: 20.0),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _deadlineCtrl,
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => _datePicker(context));
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                  label: const Text('Deadline'),
                                  floatingLabelStyle:
                                      const TextStyle(fontSize: 20.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
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
                                        const TextStyle(fontSize: 20.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Priority should not be empty';
                                  }
                                  return null;
                                },
                                value: _priorityDropdownValue,
                                items: const [
                                  DropdownMenuItem(
                                      value: 'High', child: Text('High')),
                                  DropdownMenuItem(
                                      value: 'Medium', child: Text('Medium')),
                                  DropdownMenuItem(
                                      value: 'Low', child: Text('Low'))
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _priorityDropdownValue = value as String;
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_addTodoFormKey.currentState!
                                      .validate()) {
                                    ///Call API here
                                    try {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      final uid = await _localStorageService
                                          .getUserId();

                                      ///Create a new Todos object
                                      Todo newTodo = Todo(
                                          id: "1",
                                          userId: uid!,
                                          title: _titleCtrl.text,
                                          description: _descriptionCtrl.text,
                                          updatedAt: DateTime.now(),
                                          createdAt: DateTime.now(),
                                          deadline: _newDeadline,
                                          isCompleted: false,
                                          priority:
                                              _priorityDropdownValue == "High"
                                                  ? Priority.high
                                                  : _priorityDropdownValue ==
                                                          "Medium"
                                                      ? Priority.medium
                                                      : Priority.low);

                                      final isAdded = await _restApiService
                                          .addNewTodo(newTodo);

                                      setState(() {
                                        _isLoading = false;
                                      });

                                      if (mounted) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TodoListScreen()));
                                      }
                                    } on AddTodoError catch (e) {
                                      print(e.message);
                                      setState(() {
                                        _isLoading = false;
                                        _isApiError = true;
                                      });
                                    } on NotAuthorizedError catch (_) {
                                      setState(() {
                                        _isLoading = false;
                                        _isSessionExpired = true;
                                      });
                                    }
                                  }
                                },
                                child: const Text('Submit Todo')),
                          )
                        ],
                      ),
                    ),
    );
  }

  ///Helper widget
  Widget _datePicker(BuildContext context) {
    return SafeArea(
        child: SfDateRangePicker(
      controller: DateRangePickerController(),
      selectionMode: DateRangePickerSelectionMode.single,
      showActionButtons: true,
      showNavigationArrow: true,
      confirmText: 'CONFIRM DATE',
      onCancel: () {
        Navigator.pop(context);
      },
      onSubmit: (value) {
        final selectedDate = DateTime.parse(value.toString());
        _newDeadline = selectedDate;
        _deadlineCtrl.text = formatDateToString(selectedDate);
        Navigator.pop(context);
      },
    ));
  }

  ///Helper function
  String formatDateToString(DateTime date) {
    final DateFormat dateFormat = DateFormat("EEEE, dd MMM yyyy");
    return dateFormat.format(date);
  }
}
