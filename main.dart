import 'package:flutter/material.dart';
import 'Task.dart';
import'AddTaskDialog.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'To Do List',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFDBC6C0),
      ),
      home: TodoListScreen(),
    );
  }
}






