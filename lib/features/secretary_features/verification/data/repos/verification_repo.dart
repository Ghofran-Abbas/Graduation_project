import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class VerificationRepo {
  Future<Either<Failure, dynamic>> fetchVerification({required String token,});
}