import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../db/fuctions/functions.dart';
import '../../db/model.dart';

class Userlist extends StatelessWidget {
  const Userlist({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Model>>(
      future: getAllStudents(),
      builder: (BuildContext context, AsyncSnapshot<List<Model>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Handle the case when data is still loading
          return CircularProgressIndicator();
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Text('No data available'); // Handle case when there's no data
        } else {
          // Data is ready
          // final studentList = snapshot.data!;
          print(snapshot.data);
          return ValueListenableBuilder<List<Model>>(
            valueListenable: studentNotifier,
            builder:
                (BuildContext context, List<Model> studentList, Widget? child) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final data = studentList[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: MemoryImage(
                        Uint8List.fromList(
                          base64Decode(data.picture!),
                        ),
                      ),
                      maxRadius: 20,
                    ),
                    title: Text(data.name ?? "No name"),
                    subtitle: Text(data.student_id.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showAlert(context, data.student_id);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 2,
                ),
                itemCount: studentList.length,
              );
            },
          );
        }
      },
    );
  }

  void showAlert(context, id) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Exit',
            style: GoogleFonts.lobster(
              textStyle: const TextStyle(color: Colors.red),
            ),
          ),
          content: const Text('Do you want to delete'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                await deleteStudent(id);
                // Update UI after deletion
                studentNotifier.value = await getAllStudents();
                studentNotifier.notifyListeners();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
}
