import 'package:alhadara_dashboard/features/secretary_features/department/data/models/departments_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/data/models/details_department_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class DepartmentRepo {

  Future<Either<Failure, DepartmentsModel>> fetchDepartments({required int page});

  Future<Either<Failure, DetailsDepartmentModel>> fetchDetailsDepartment({
    required int id,
  });
}