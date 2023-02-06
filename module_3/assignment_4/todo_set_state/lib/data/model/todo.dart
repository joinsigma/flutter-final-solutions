import 'package:flutter/material.dart';

enum Priority { high, medium, low }

class Todo {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deadline;
  final Priority priority;
  final bool isCompleted;

  Todo(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.priority,
      required this.deadline,
      required this.updatedAt,
      required this.isCompleted});

  ///Convert from JSON to object
  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        title = json['title'],
        description = json['description'],
        isCompleted = json['isCompleted'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']),
        deadline = DateTime.parse(json['deadline']),
        priority = _assignPriorityEnum(json['priority']);

  ///Convert from object to JSON Map<String,dynamic>
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'deadline': deadline.toString(),
      'priority': _assignPriorityString(priority)
    };
  }

  ///Helper
  static _assignPriorityEnum(String jsonPriority) {
    Priority p;
    switch (jsonPriority) {
      case "HIGH":
        p = Priority.high;
        break;
      case "MEDIUM":
        p = Priority.medium;
        break;
      case "LOW":
        p = Priority.low;
        break;
      default:
        p = Priority.low;
    }
    return p;
  }

  static _assignPriorityString(Priority enumPriority) {
    String p;
    switch (enumPriority) {
      case Priority.high:
        p = "HIGH";
        break;
      case Priority.medium:
        p = "MEDIUM";
        break;
      case Priority.low:
        p = "LOW";
        break;
      default:
        p = "LOW";
    }
    return p;
  }
}
