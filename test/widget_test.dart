// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:serina/main.dart';

import 'dart:math';

String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  final result = List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  return result;
}

void main() {
  final randomString = generateRandomString(16); // Change the length as needed
  print('Random String: $randomString');
}

