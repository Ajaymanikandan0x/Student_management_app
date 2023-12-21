import 'package:flutter/material.dart';

import 'package:student_app/pages/sub/listveiw.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: const Text(
          'Home',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/adduser');
        },
        backgroundColor: Colors.teal[800],
        child: const Icon(Icons.add),
      ),
      body: Userlist(),
    );
  }
}
