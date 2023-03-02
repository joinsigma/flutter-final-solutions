import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/ui/common/widgets/network_error_display.dart';
import 'package:flutter_todo_bloc/ui/edit/bloc/todo_edit_bloc.dart';
import 'package:flutter_todo_bloc/ui/edit/bloc/todo_edit_event.dart';
import 'package:flutter_todo_bloc/ui/edit/bloc/todo_edit_state.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../data/model/todo.dart';
import '../../data/network/exceptions.dart';
import '../../data/network/rest_api_service.dart';
import '../common/widgets/api_error_display.dart';
import '../common/widgets/loading_indicator.dart';
import '../common/widgets/login_redirect_display.dart';
import '../listing/todo_list_screen.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class TodoEditScreen extends StatefulWidget {
  final Todo todo;
  const TodoEditScreen({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  late TodoEditBloc _todoEditBloc;
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;
  late TextEditingController _deadlineCtrl;
  late String _priorityDropdownValue;
  late DateTime _newDeadline;
  late GlobalKey<FormState> _editTodoFormKey;

  @override
  void initState() {
    _todoEditBloc = kiwi.KiwiContainer().resolve<TodoEditBloc>();
    _titleCtrl = TextEditingController(text: widget.todo.title);
    _descriptionCtrl = TextEditingController(text: widget.todo.description);
    _deadlineCtrl =
        TextEditingController(text: formatDateToString(widget.todo.deadline));
    _priorityDropdownValue = widget.todo.priority == Priority.high
        ? 'High'
        : widget.todo.priority == Priority.medium
            ? 'Medium'
            : 'Low';
    _newDeadline = DateTime.now();
    _editTodoFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _todoEditBloc.close();
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    _deadlineCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _todoEditBloc,
      child: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: const Text('Edit Todo'),
        ),
        body: BlocConsumer<TodoEditBloc, TodoEditState>(
          listener: (context, state) {
            if (state is TodoEditSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoListScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is TodoEditLoading) {
              return const LoadingIndicator();
            } else if (state is TodoEditInitial) {
              return Form(
                key: _editTodoFormKey,
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
                            if (_editTodoFormKey.currentState!.validate()) {
                              ///Add event
                              _todoEditBloc.add(SaveTodo(
                                  description: _descriptionCtrl.text,
                                  id: widget.todo.id,
                                  userId: widget.todo.userId,
                                  title: _titleCtrl.text,
                                  createdAt: widget.todo.createdAt,
                                  priority: _priorityDropdownValue == "High"
                                      ? Priority.high
                                      : _priorityDropdownValue == "Medium"
                                          ? Priority.medium
                                          : Priority.low,
                                  isCompleted: widget.todo.isCompleted,
                                  deadline: _newDeadline));
                            }
                          },
                          child: const Text('Save Todo')),
                    )
                  ],
                ),
              );
            } else if (state is TodoEditFailure) {
              if (state.isApiError) {
                return const ApiErrorDisplay();
              } else if (state.isSessionExpired) {
                return const LoginRedirectDisplay();
              } else if (state.isNetworkError) {
                return const NetworkErrorDisplay();
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
