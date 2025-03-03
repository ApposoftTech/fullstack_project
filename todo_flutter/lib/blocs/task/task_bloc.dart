import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../../core/api_service.dart';
import '../../models/task.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ApiService apiService;

  TaskBloc({required this.apiService}) : super(TaskInitial()) {
    on<FetchTasks>(_onFetchTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final response =
      await apiService.fetchTasks(page: event.page, limit: event.limit);
      //final List<Task> tasks = (response.data as List).map((task) => Task.fromJson(task)).toList();
      //final Map<String, dynamic> taskss = json.decode(response.data);
      final List<Task> tasks = (response.data['tasks'] as List)
          .map((task) => Task.fromJson(task))
          .toList();
      emit(TaskLoaded(
          tasks: tasks,
          currentPage: event.page,
          hasMore: tasks.length == event.limit));
    } catch (e) {
      emit(TaskError('Failed to fetch tasks!'));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      await apiService.addTask(event.title, event.description);
      add(FetchTasks());
    } catch (e) {
      emit(TaskError('Failed to add task!'));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    try {
      await apiService.updateTask(
          event.id, event.title, event.description, event.status);
      add(FetchTasks());
    } catch (e) {
      emit(TaskError('Failed to update task!'));
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await apiService.deleteTask(event.id);
      add(FetchTasks());
    } catch (e) {
      emit(TaskError('Failed to delete task!'));
    }
  }
}
