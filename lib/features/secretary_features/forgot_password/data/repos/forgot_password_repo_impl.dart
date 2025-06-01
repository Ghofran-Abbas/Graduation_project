import 'dart:developer';

import 'package:alhadara_dashboard/constants.dart';
import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/api_service.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/forgot_password_model.dart';
import 'forgot_password_repo.dart';

class ForgotPasswordRepoImpl extends ForgotPasswordRepo{

  final DioApiService dioApiService;
  static var dio = Dio();

  ForgotPasswordRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, ForgotPasswordModel>> fetchForgotPassword({
    required String email,
  }) async {
    try{
      var data = await (dioApiService.post(
        endPoint: '/auth/secretary/forgotPassword',
        data: {
          "email": email,
        },
        token: Constants.adminToken,
      ));
      log(data.toString());
      ForgotPasswordModel forgotPasswordModel;
      forgotPasswordModel = ForgotPasswordModel.fromJson(data);

      return right(forgotPasswordModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}