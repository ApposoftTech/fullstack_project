import 'package:flutter/material.dart';
import '../models/task.dart';
import '../screens/edit_task_screen.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            SizedBox(height: 5),
            Text("Status: ${task.status}",
                style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditTaskScreen(task: task)),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                BlocProvider.of<TaskBloc>(context).add(DeleteTask(id: task.id));
              },
            ),
          ],
        ),
      ),
    );
  }
}
