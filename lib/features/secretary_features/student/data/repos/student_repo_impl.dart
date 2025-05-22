import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/create_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/delete_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/details_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/search_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/update_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/repos/student_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../models/students_model.dart';

class StudentRepoImpl extends StudentRepo{

  final DioApiService dioApiService;

  StudentRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, StudentsModel>> fetchStudents({required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/student/showAllStudent?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      StudentsModel studentsModel;
      studentsModel = StudentsModel.fromJson(data);

      return right(studentsModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateStudentModel>> fetchCreateStudent({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required Uint8List photo,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "birthday": birthday,
      "photo": MultipartFile.fromBytes(
        photo,
        filename: 'upload.png',
      ),
    });

    try {
      var data = await (dioApiService.postWithImage(
        endPoint: '/secretary/student/registrationStudent',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      CreateStudentModel createStudentModel;
      createStudentModel = CreateStudentModel.fromJson(data);

      return right(createStudentModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateStudentModel>> fetchUpdateStudent({
    required int id,
    String? name,
    String? phone,
    String? birthday,
    String? gender,
    Uint8List? photo,
  }) async {
    final Map<String, dynamic> dataMap = {};

    if (name != null && name.trim().isNotEmpty) {
      dataMap['name'] = name;
    }

    if (phone != null && phone.trim().isNotEmpty) {
      dataMap['phone'] = phone;
    }

    if (birthday != null && birthday.trim().isNotEmpty) {
      dataMap['birthday'] = birthday;
    }

    if (gender != null && gender.trim().isNotEmpty) {
      dataMap['gender'] = birthday;
    }

    if (photo != null) {
      dataMap['photo'] = MultipartFile.fromBytes(
        photo,
        filename: 'upload.png',
      );
    }

    if (dataMap.isEmpty) {
      return left(ServerFailure('يجب تعديل حقل واحد على الأقل قبل الإرسال.'));
    }

    final formData = FormData.fromMap(dataMap);

    try {
      var data = await (dioApiService.postWithImage(
        endPoint: '/secretary/student/updateStudent/$id',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      UpdateStudentModel updateStudentModel;
      updateStudentModel = UpdateStudentModel.fromJson(data);

      return right(updateStudentModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteStudentModel>> fetchDeleteStudent({required int id}) async {
    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/student/deleteStudent/$id',
        data: {
          "id": id,
        },
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DeleteStudentModel deleteStudentModel;
      deleteStudentModel = DeleteStudentModel.fromJson(data);

      return right(deleteStudentModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsStudentModel>> fetchDetailsStudent({required int id}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/student/showStudentById/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DetailsStudentModel detailsStudentModel;
      detailsStudentModel = DetailsStudentModel.fromJson(data);

      return right(detailsStudentModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchStudentModel>> fetchSearchStudent({required String querySearch, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/student/searchStudent/$querySearch?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      SearchStudentModel searchStudentModel;
      searchStudentModel = SearchStudentModel.fromJson(data);

      return right(searchStudentModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}