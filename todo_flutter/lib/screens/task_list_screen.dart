import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';
import '../blocs/task/task_state.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late TaskBloc _taskBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _taskBloc = BlocProvider.of<TaskBloc>(context);
    _taskBloc.add(FetchTasks());

    // Infinite scrolling listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final currentState = _taskBloc.state;
        if (currentState is TaskLoaded && currentState.hasMore) {
          _taskBloc.add(FetchTasks(page: currentState.currentPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task List')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.tasks.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.tasks.length) {
                  return Center(child: CircularProgressIndicator());
                }
                return TaskCard(task: state.tasks[index]);
              },
            );
          } else if (state is TaskError) {
            return Center(
                child:
                Text(state.message, style: TextStyle(color: Colors.red)));
          }
          return Center(child: Text('No tasks available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTaskScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
