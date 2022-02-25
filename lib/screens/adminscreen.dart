import 'package:fanpage_app/screens/add.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => const AddPost())
          );
        },
        child: Icon(Icons.add),
         ),
    );
  }
}
