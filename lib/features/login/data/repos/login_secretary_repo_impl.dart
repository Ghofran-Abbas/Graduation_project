import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/api_service.dart';
import 'package:alhadara_dashboard/features/login/data/models/login_secretary_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../constants.dart';
import '../../../../core/utils/shared_preferences_helper.dart';
import 'login_secretary_repo.dart';

class LoginRepoImpl extends LoginRepo{

  final DioApiService dioApiService;

  LoginRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, LoginSecretaryModel>> fetchLoginSecretary({
    required String email,
    required String password,
    required String fcm_token,
  }) async {
    try{
      log('${await SharedPreferencesHelper.getFcmToken()}');
      var data = await (dioApiService.post(
        endPoint: '/auth/secretary/login',
        data: {
          "email": email,
          "password": password,
          "fcm_token": await SharedPreferencesHelper.getFcmToken()/*fcm_token*/,
        },
        token: '',
      ));
      log(data.toString());
      LoginSecretaryModel loginSecretaryModel;
      loginSecretaryModel = LoginSecretaryModel.fromJson(data);

      return right(loginSecretaryModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure('DioException ${e.response!.data['Message'].toString()}'));
      } else {
        log(e.toString());
        return left(ServerFailure(e.toString()));
      }
    }
  }

}