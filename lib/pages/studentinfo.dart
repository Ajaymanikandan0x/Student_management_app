import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../db/fuctions/functions.dart';
import '../db/model.dart';

class StudentInfo extends StatelessWidget {
  final String selectimg;
  final String name;
  final int student_id;
  final int age;
  final String batch;
  final int? id;

  // Separate controllers for each text field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController batchController = TextEditingController();

  StudentInfo({
    required this.selectimg,
    required this.name,
    required this.student_id,
    required this.age,
    required this.batch,
    required this.id,
  }) {
    // Initialize controllers with provided values
    nameController.text = name;
    ageController.text = age.toString();
    idController.text = student_id.toString();
    batchController.text = batch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        centerTitle: true,
        title: const Text('StudentInfo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 65),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Use CircleAvatar properly
            CircleAvatar(
              radius: 80,
              foregroundColor: Colors.blueGrey,
              backgroundImage: selectimg != null
                  ? MemoryImage(
                      Uint8List.fromList(
                        base64Decode(selectimg),
                      ),
                    )
                  : null,
              child: selectimg == null ? Icon(Icons.person) : null,
            ),

            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            sizeBox,
            TextField(
              controller: idController,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            sizeBox,
            TextField(
              controller: ageController,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            sizeBox,
            TextField(
              controller: batchController,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    backgroundColor: Colors.teal[800],
                  ),
                  icon: const Icon(Icons.exit_to_app_rounded,
                      color: Colors.black),
                  label: const Text(
                    'Back',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final model = Model(
                      id: id,
                      name: nameController.text,
                      age: int.parse(ageController.text),
                      student_id: int.parse(idController.text),
                      batch: batchController.text,
                      picture: selectimg,
                    );
                    print("Updating stu-model with id: ${model.id}");
                    await updateStudent(model);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    backgroundColor: Colors.teal[800],
                  ),
                  icon: const Icon(Icons.update, color: Colors.black),
                  label: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget sizeBox = const SizedBox(height: 10);
}
