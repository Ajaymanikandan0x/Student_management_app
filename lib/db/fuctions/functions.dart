import 'package:flutter/material.dart';
import 'package:student_app/db/model.dart';

ValueNotifier<List<Model>> student_notifer = ValueNotifier([]);

void addstudent(Model value) {
  student_notifer.value.add(value);
  student_notifer.notifyListeners();
}
