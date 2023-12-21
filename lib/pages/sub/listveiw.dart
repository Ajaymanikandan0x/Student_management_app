import 'package:flutter/material.dart';

import '../../db/fuctions/functions.dart';
import '../../db/model.dart';

class Userlist extends StatelessWidget {
  const Userlist({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: student_notifer,
      builder: (BuildContext context, List<Model> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = studentList[index];
            return ListTile(
              title: Text(data.name ?? "No name"),
              subtitle: Text(data.id.toString()),
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
}
