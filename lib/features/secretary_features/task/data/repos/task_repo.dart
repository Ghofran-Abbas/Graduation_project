import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/tasks_model.dart';
import '../models/update_task_model.dart';

abstract class TaskRepo {
  Future<Either<Failure, TasksModel>> fetchTasks({required int page});

  Future<Either<Failure, UpdateTaskModel>> fetchUpdateSection({required int taskId, required String state,});
}