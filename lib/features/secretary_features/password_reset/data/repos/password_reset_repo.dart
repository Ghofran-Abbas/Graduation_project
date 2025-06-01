import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/password_reset_model.dart';

abstract class PasswordResetRepo {
  Future<Either<Failure, PasswordResetModel>> fetchPasswordReset({
    required String token,
    required String password,
    required String password_confirmation,
  });
}