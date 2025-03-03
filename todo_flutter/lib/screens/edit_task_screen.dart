import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _status = 'pending';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _status = widget.task.status;
  }

  void _updateTask() {
    BlocProvider.of<TaskBloc>(context).add(
      UpdateTask(
        id: widget.task.id,
        title: _titleController.text,
        description: _descriptionController.text,
        status: _status,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Task')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title')),
            TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description')),
            DropdownButton<String>(
              value: _status,
              onChanged: (String? newValue) {
                setState(() => _status = newValue!);
              },
              items:
              ['pending', 'in-progress', 'completed'].map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _updateTask, child: Text('Update Task')),
          ],
        ),
      ),
    );
  }
}
