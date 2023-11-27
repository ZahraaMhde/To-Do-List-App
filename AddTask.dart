import 'package:flutter/material.dart';
import 'Task.dart';

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
