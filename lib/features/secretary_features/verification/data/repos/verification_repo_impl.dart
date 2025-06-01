import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/utils/api_service.dart';
import 'verification_repo.dart';

class VerificationRepoImpl extends VerificationRepo{

  final DioApiService dioApiService;

  VerificationRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, dynamic>> fetchVerification({required String token,}) async {
    try{
      var data = await (dioApiService.post(
        endPoint: '/auth/secretary/verificationEmail',
        data: {
          "token": token,
        },
        token: '',
      ));
      log(data.toString());
      /*VerificationModel verificationModel;
      verificationModel = VerificationModel.fromJson(data);*/

      return right(data);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}