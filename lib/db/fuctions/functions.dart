import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_app/db/model.dart';

ValueNotifier<List<Model>> studentNotifier = ValueNotifier([]);

Future<Database> database() async {
  final db = await openDatabase('student_db', version: 1,
      onCreate: (db, version) async {
    await db.execute(
        'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, student_id INTEGER, batch TEXT, picture TEXT)');
  });

  return db;
}

Future<List<Model>> getAllStudents() async {
  final db = await database();
  final List<Map<String, dynamic>> maps = await db.query('student',
      columns: ['name', 'age', 'student_id', 'batch', 'picture']);
  final List<Model> templist = [];
  maps.forEach((element) {
    templist.add(Model.fromMap(element));
  });
  studentNotifier.value = templist;
  // Add student to existing list
  studentNotifier.notifyListeners();

  // Fetch selective columns
  // final List<Model> templist = List.generate(maps.length,
  //     (i) { return Model.fromMap(maps[i])}; // Use Model.fromMap factory constructor
  // print(templist.length);
  // print('get all student called');
  return templist;
}

Future<void> addStudent(Model student) async {
  try {
    final db = await database();
    final result = await db.insert('student', student.toMap());
    studentNotifier.value.add(student); // Add student to existing list
    studentNotifier.notifyListeners();
  } catch (e) {
    print("Error adding student: ${e.toString()}");
  }
}

Future<void> deleteStudent(int studentId) async {
  try {
    final db = await database();
    await db.rawDelete('DELETE FROM student WHERE student_id = ?', [studentId]);
    studentNotifier.value.removeWhere((student) =>
        student.student_id == studentId); // Remove from existing list
    studentNotifier.notifyListeners();
  } catch (e) {
    print("Error deleting student: ${e.toString()}");
  }
}
