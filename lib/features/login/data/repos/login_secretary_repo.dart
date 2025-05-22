import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/login_secretary_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginSecretaryModel>> fetchLoginSecretary({
    required String email,
    required String password,
    required String fcm_token,
  });
}