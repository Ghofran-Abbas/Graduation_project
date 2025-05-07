import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/verification_model.dart';

abstract class VerificationRepo {
  Future<Either<Failure, VerificationModel>> fetchVerification({
    required String token,
    required String password,
    required String password_confirmation,
  });
}