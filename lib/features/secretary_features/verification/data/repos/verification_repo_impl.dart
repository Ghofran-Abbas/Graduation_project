import 'dart:developer';

import 'package:alhadara_dashboard/constants.dart';
import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/api_service.dart';
import 'package:alhadara_dashboard/features/secretary_features/verification/data/models/verification_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/verification/data/repos/verification_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class VerificationRepoImpl extends VerificationRepo{

  final DioApiService dioApiService;
  static var dio = Dio();

  VerificationRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, VerificationModel>> fetchVerification({
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
      VerificationModel verificationModel;
      verificationModel = VerificationModel.fromJson(data);

      return right(verificationModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}