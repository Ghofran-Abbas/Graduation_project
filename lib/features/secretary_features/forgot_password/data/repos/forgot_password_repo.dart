import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/forgot_password_model.dart';

abstract class ForgotPasswordRepo {
  Future<Either<Failure, ForgotPasswordModel>> fetchForgotPassword({
    required String email,
  });
}