import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTasks extends TaskEvent {
  final int page;
  final int limit;

  FetchTasks({this.page = 1, this.limit = 10});

  @override
  List<Object?> get props => [page, limit];
}

class AddTask extends TaskEvent {
  final String title;
  final String description;

  AddTask({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

class UpdateTask extends TaskEvent {
  final String id;
  final String title;
  final String description;
  final String status;

  UpdateTask(
      {required this.id,
        required this.title,
        required this.description,
        required this.status});

  @override
  List<Object?> get props => [id, title, description, status];
}

class DeleteTask extends TaskEvent {
  final String id;

  DeleteTask({required this.id});

  @override
  List<Object?> get props => [id];
}
