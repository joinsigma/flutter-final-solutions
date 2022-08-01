import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

final InputDecoration kLoginTextFieldStyle = InputDecoration(
  filled: true,
  fillColor: Colors.brown[100],
  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.black),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide.none,
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
  ),
);

final PinTheme defaultPinTheme = PinTheme(
  width: 56,
  height: 60,
  decoration: BoxDecoration(
    color: const Color.fromRGBO(222, 231, 240, .57),
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: Colors.black38),
  ),
);
