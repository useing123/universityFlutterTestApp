import 'package:flutter/material.dart';
import 'screens/todo_list_screen.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue, // You can adjust the color
      ),
      home: ToDoListScreen(),
    );
  }
}
