import 'package:intl/intl.dart';

import '../../data/model/todo.dart';

///Helper
mixin Helper {
  String assignDropDownPriorityValue(Priority priority) {
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

  Priority convertStringToPriority(String priority) {
    Priority p;

    switch (priority) {
      case "High":
        p = Priority.high;
        break;
      case "Medium":
        p = Priority.medium;
        break;
      case "Low":
        p = Priority.low;
        break;
      default:
        p = Priority.low;
    }
    return p;
  }

  String convertPriorityToString(Priority priority) {
    String p;

    switch (priority) {
      case Priority.high:
        p = "High";
        break;
      case Priority.medium:
        p = "Medium";
        break;
      case Priority.low:
        p = "Low";
        break;
      default:
        p = "Low";
    }
    return p;
  }

  String formatDateToString(DateTime date) {
    final DateFormat dateFormat = DateFormat('EEEE, dd MMM yyyy');
    return dateFormat.format(date);
  }

  DateTime formatStringToDate(String date) {
    return DateTime.parse(date);
  }
}
