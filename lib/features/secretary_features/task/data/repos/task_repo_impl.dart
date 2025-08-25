import 'dart:developer';

import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/api_service.dart';
import 'package:alhadara_dashboard/features/secretary_features/task/data/models/tasks_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/task/data/models/update_task_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/task/data/repos/task_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/utils/shared_preferences_helper.dart';

class TaskRepoImpl extends TaskRepo{
  final DioApiService dioApiService;

  TaskRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, TasksModel>> fetchTasks({required int page}) async {
    try {
      var data = await dioApiService.get(
          endPoint: '/secretary/task/showMyTask?page=$page',
          token: await SharedPreferencesHelper.getJwtToken(),
    );
    log(data.toString());
    TasksModel tasksModel;
      tasksModel = TasksModel.fromJson(data);

    return right(tasksModel);

    } catch(e) {
    if (e is DioException){
    return left(ServerFailure.fromDioError(e),);
    }
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateTaskModel>> fetchUpdateSection({required int taskId, required String state}) async {

    final Map<String, dynamic> updateData = {};
    if(state == 'Pending') {
      updateData['status'] = 'pending';
    } else if(state == 'In progress') {
      updateData['status'] = 'in_progress';
    } else if(state == 'Completed') {
      updateData['status'] = 'completed';
    } else {
      updateData['status'] = state;
    }

    log("Update data is: ${updateData.toString()}");

    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/task/changeStatusTask/$taskId',
        data: updateData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));

      log(data.toString());
      UpdateTaskModel updateTaskModel;
      updateTaskModel = UpdateTaskModel.fromJson(data);

      return right(updateTaskModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}