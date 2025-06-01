import 'dart:developer';

import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/api_service.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/password_reset_model.dart';
import 'password_reset_repo.dart';

class PasswordResetRepoImpl extends PasswordResetRepo{

  final DioApiService dioApiService;
  static var dio = Dio();

  PasswordResetRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, PasswordResetModel>> fetchPasswordReset({
    required String token,
    required String password,
    required String password_confirmation,
  }) async {
    try{
      var data = await (dioApiService.post(
        endPoint: '/auth/secretary/passwordReset',
        data: {
          "token": token,
          "password": password,
          "password_confirmation": password_confirmation,
        },
        token: '',
      ));
      log(data.toString());
      PasswordResetModel passwordResetModel;
      passwordResetModel = PasswordResetModel.fromJson(data);

      return right(passwordResetModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}