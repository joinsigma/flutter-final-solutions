import 'package:flutter/material.dart';

final InputDecoration kLoginTextFieldStyle = InputDecoration(
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.black),
  ),
  border: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
);