import 'package:flutter/material.dart';
import'AddTaskDialog.dart';

class Task {
  String name;
  bool isCompleted;
  DateTime dateTime;

  Task({required this.name, required this.isCompleted, required this.dateTime});
}


class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];

  void addTask(String task, DateTime dateTime) {
    setState(() {
      tasks.add(Task(name: task, dateTime: dateTime, isCompleted: false));
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        backgroundColor: Color(0xFF1C3150),
      ),
      body: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                toggleTaskCompletion(index);
              },
              fillColor: MaterialStateColor.resolveWith((states) {
                var value;
                if (value == true) {
                  return Color(0xFF78809D);
                } else {
                  return Colors.transparent;
                }
              }),
            ),
            title: Text(task.name),
            subtitle: Text('${task.dateTime}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteTask(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(
              onAddTask: addTask,
            ),
          );
        },
        backgroundColor: Color(0xFF4D6489), 
        child: Icon(Icons.add),
      ),
    );
  }
}
