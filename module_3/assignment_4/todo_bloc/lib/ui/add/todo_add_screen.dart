import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/add/bloc/todo_add_bloc.dart';
import 'package:flutter_todo_bloc/ui/add/bloc/todo_add_event.dart';
import 'package:flutter_todo_bloc/ui/add/bloc/todo_add_state.dart';
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
import 'package:kiwi/kiwi.dart' as kiwi;

class TodoAddScreen extends StatefulWidget {
  const TodoAddScreen({Key? key}) : super(key: key);

  @override
  State<TodoAddScreen> createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  late TodoAddBloc _todoAddBloc;
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
    _todoAddBloc = kiwi.KiwiContainer().resolve<TodoAddBloc>();
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
  void dispose() {
    _todoAddBloc.close();
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    _deadlineCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _todoAddBloc,
      child: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: const Text('Add Todo'),
        ),
        body: BlocConsumer<TodoAddBloc, TodoAddState>(
          listener: (context, state) {
            if (state is TodoAddSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoListScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            ///Loading
            if (state is TodoAddLoading) {
              return const LoadingIndicator();
            }
            if (state is TodoAddInitial) {
              return Form(
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
                          floatingLabelStyle: const TextStyle(fontSize: 20.0),
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
                          floatingLabelStyle: const TextStyle(fontSize: 20.0),
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
                            floatingLabelStyle: const TextStyle(fontSize: 20.0),
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
                                  borderRadius: BorderRadius.circular(10))),
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
                            DropdownMenuItem(value: 'Low', child: Text('Low'))
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
                          if (_addTodoFormKey.currentState!.validate()) {
                            ///Trigger event
                            _todoAddBloc.add(
                              AddNewTodo(
                                title: _titleCtrl.text,
                                description: _descriptionCtrl.text,
                                isCompleted: false,
                                deadline: _newDeadline,
                                priority: _priorityDropdownValue == "High"
                                    ? Priority.high
                                    : _priorityDropdownValue == "Medium"
                                        ? Priority.medium
                                        : Priority.low,
                              ),
                            );
                          }
                        },
                        child: const Text('Submit Todo'),
                      ),
                    )
                  ],
                ),
              );
            }

            ///Failure
            else if (state is TodoAddFailure) {
              if (state.isApiError) {
                return const ApiErrorDisplay();
              } else if (state.isSessionExpired) {
                return const LoginRedirectDisplay();
              }
            }
            return Container();
          },
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
