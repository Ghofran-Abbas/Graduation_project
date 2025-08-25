import 'package:equatable/equatable.dart';

import '../../../data/models/tasks_model.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TasksInitial extends TasksState {}
class TasksLoading extends TasksState {}
class TasksFailure extends TasksState {
  final String errorMessage;

  const TasksFailure(this.errorMessage);
}
class TasksSuccess extends TasksState {
  final TasksModel tasks;

  const TasksSuccess(this.tasks);
}