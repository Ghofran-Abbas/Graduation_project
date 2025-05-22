import 'package:alhadara_dashboard/features/secretary_features/logout/data/models/logout_secretary_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class LogoutSecretaryRepo {
  Future<Either<Failure, LogoutSecretaryModel>> fetchLogoutSecretary();
}