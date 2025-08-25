import 'package:equatable/equatable.dart';

import '../../../data/models/update_task_model.dart';

abstract class UpdateTaskState extends Equatable {
  const UpdateTaskState();

  @override
  List<Object?> get props => [];
}

class UpdateTaskInitial extends UpdateTaskState {}
class UpdateTaskLoading extends UpdateTaskState {}
class UpdateTaskFailure extends UpdateTaskState {
  final String errorMessage;

  const UpdateTaskFailure(this.errorMessage);
}
class UpdateTaskSuccess extends UpdateTaskState {
  final UpdateTaskModel result;

  const UpdateTaskSuccess(this.result);
}