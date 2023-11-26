import 'package:flutter/material.dart';
import 'Task.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFDBC6C0), // Background color
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Color(0xFF4D6489)), // Font color
        ),
      ),
      home: TodoListScreen(),
    );
  }
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
        backgroundColor: Color(0xFF1C3150), // AppBar background color
      ),
      body: ListView.separated(
        itemCount: tasks.length,
        separatorBuilder: (context, index) => Divider(), // Add a divider between tasks
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
                if (value == true) { // Use value directly without comparing to true
                  return Color(0xFF78809D); // Checkbox color when checked
                } else {
                  return Colors.transparent;
                }
              }),
            ),
            title: Text(task.name),
            subtitle: Text('${task.dateTime}'), // Display the date and time
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Handle edit task
                  },
                ),
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
          // Show add task dialog
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(
              onAddTask: addTask,
            ),
          );
        },
        backgroundColor: Color(0xFF4D6489), // Add button color
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTaskDialog extends StatefulWidget {
  final Function(String, DateTime) onAddTask;

  AddTaskDialog({required this.onAddTask});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late TextEditingController _taskController;
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController();
    _selectedDateTime = DateTime.now();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _taskController,
            decoration: InputDecoration(labelText: 'Task'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final selectedDateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2024),
              );

              if (selectedDateTime != null) {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime != null) {
                  setState(() {
                    _selectedDateTime = DateTime(
                      selectedDateTime.year,
                      selectedDateTime.month,
                      selectedDateTime.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );
                  });
                }
              }
            },
            child: Text('Select Date and Time'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final task = _taskController.text;
            widget.onAddTask(task, _selectedDateTime);
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}







