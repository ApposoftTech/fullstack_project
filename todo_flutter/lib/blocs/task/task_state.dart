import 'package:equatable/equatable.dart';
import '../../models/task.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final int currentPage;
  final bool hasMore;

  TaskLoaded(
      {required this.tasks, required this.currentPage, required this.hasMore});

  @override
  List<Object?> get props => [tasks, currentPage, hasMore];
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);

  @override
  List<Object?> get props => [message];
}
