import 'dart:developer';

import 'package:alhadara_dashboard/constants.dart';
import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/api_service.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/data/models/departments_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/data/repos/department_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/details_department_model.dart';

class DepartmentRepoImpl extends DepartmentRepo{
  final DioApiService dioApiService;

  DepartmentRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, DepartmentsModel>> fetchDepartments({required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/admin/departments?page=$page',
        token: Constants.adminToken,
      ));
      log(data.toString());
      DepartmentsModel departmentsModel;
      departmentsModel = DepartmentsModel.fromJson(data);

      return right(departmentsModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsDepartmentModel>> fetchDetailsDepartment({required int id}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/admin/departments/$id',
        token: Constants.adminToken,
      ));
      log(data.toString());
      DetailsDepartmentModel detailsDepartmentModel;
      detailsDepartmentModel = DetailsDepartmentModel.fromJson(data);

      return right(detailsDepartmentModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}