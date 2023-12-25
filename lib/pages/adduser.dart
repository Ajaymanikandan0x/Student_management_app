import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:student_app/db/model.dart';
import 'package:image_picker/image_picker.dart';
import '../db/fuctions/functions.dart';

class Adduser extends StatefulWidget {
  Adduser({super.key});

  @override
  State<Adduser> createState() => _AdduserState();
}

class _AdduserState extends State<Adduser> {
  final name = TextEditingController();

  final age = TextEditingController();

  final id = TextEditingController();

  final batch = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? selectimg;
  String? base64Image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student'),
        centerTitle: true,
        backgroundColor: Colors.teal[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _getImage();
                },
                child: CircleAvatar(
                  maxRadius: 80,
                  foregroundColor: Colors.blueGrey,
                  child: selectimg != null
                      ? Image.file(selectimg!)
                      : const Padding(
                          padding: EdgeInsets.all(20),
                          child: Icon(Icons.person)),
                ),
              ),
              sizedbox,
              TextFormField(
                style: const TextStyle(
                  letterSpacing: 2,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: name,
                validator: (value) {
                  if (value == null ||
                      value!.isEmpty ||
                      !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return "Please enter a correct name";
                  } else {
                    return null;
                  }
                },
              ),
              sizedbox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      style: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        hintText: 'age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: age,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter your age.";
                        }

                        if (!RegExp(r'^\d{1,2}$').hasMatch(value)) {
                          return "Please enter a valid age (up to 2 digits).";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 240,
                    child: TextFormField(
                      style: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Batch',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: batch,
                      validator: (value) {
                        if (value == null ||
                            value!.isEmpty ||
                            !RegExp(r'^[a-zA-Z 0-9]+$').hasMatch(value)) {
                          return "Please enter valid batch number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              sizedbox,
              TextFormField(
                  style: const TextStyle(
                    letterSpacing: 2,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Id_number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: id,
                  validator: (value) {
                    if (value == null) {
                      return "Please enter an ID";
                    }
                    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                      return "Please enter a valid 6-digit ID";
                    }

                    return null; // Valid ID
                  }),
              sizedbox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        add_student(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50),
                      backgroundColor: Colors.teal[800],
                    ),
                    icon: Icon(Icons.save, color: Colors.black),
                    label: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 50),
                      backgroundColor: Colors.teal[800],
                    ),
                    icon: Icon(Icons.exit_to_app_rounded, color: Colors.black),
                    label: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget sizedbox = const SizedBox(
    height: 15,
  );

  Future<void> _getImage() async {
    try {
      final picker = ImagePicker();
      final XFile? imageselect =
          await picker.pickImage(source: ImageSource.gallery);

      if (imageselect == null) {
        // No image selected
        return;
      }
      Uint8List imageBytes =
          await imageselect.readAsBytes(); // Use Uint8List for image bytes
      String base64Image = base64Encode(imageBytes);
      setState(() {
        selectimg = File(imageselect.path);
        this.base64Image = base64Image;
      });
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> add_student(BuildContext context) async {
    final _names = name.text.trim();
    final _age = int.parse(age.text);
    final _id = int.parse(id.text);
    final _batch = batch.text;
    if (_names.isEmpty && _age == null && _id == null && _batch.isEmpty) {
      return;
    } else {
      final model = Model(
          name: _names,
          age: _age,
          student_id: _id,
          batch: _batch,
          picture: base64Image);
      addStudent(model);
      Navigator.pushNamed(context, '/home');
    }
  }
}
