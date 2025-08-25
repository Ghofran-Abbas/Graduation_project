import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../models/notifications_model.dart';
import 'notification_repo.dart';

class NotificationRepoImpl extends NotificationRepo{
  final DioApiService dioApiService;

  NotificationRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, NotificationsModel>> fetchNotifications() async {
    try {
      var data = await dioApiService.get(
        endPoint: '/notifications/indexNotificationsSecretary',
        token: await SharedPreferencesHelper.getJwtToken(),
      );
      log(data.toString());
      NotificationsModel tasksModel;
      tasksModel = NotificationsModel.fromJson(data);

      return right(tasksModel);

    } catch(e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}