import 'package:flutter/material.dart';
import 'package:flutter_tes/widgets/task_list.dart';

class ToDoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: TaskList(),
    );
  }
}
