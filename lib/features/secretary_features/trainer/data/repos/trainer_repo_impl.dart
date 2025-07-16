import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/api_service.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/archive_section_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/create_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/delete_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/details_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/update_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/utils/shared_preferences_helper.dart';
import '../models/search_trainer_model.dart';
import '../models/trainers_model.dart';

class TrainerRepoImpl extends TrainerRepo{

  final DioApiService dioApiService;
  static var dio = Dio();

  TrainerRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, CreateTrainerModel>> fetchCreateTrainer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required Uint8List photo,
    required String gender,
    required String specialization,
    required String experience,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "photo": MultipartFile.fromBytes(
        photo,
        filename: 'upload.png',
      ),
      "gender": gender,
      "birthday": birthday,
      "specialization": specialization,
      "experience": experience,
    });

    try{
      var data = await (dioApiService.postWithImage(
        endPoint: '/secretary/trainer/trainerRegistration',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      CreateTrainerModel createTrainerModel;
      createTrainerModel = CreateTrainerModel.fromJson(data);

      return right(createTrainerModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainersModel>> fetchTrainers({required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/trainer/showAllTrainer?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      TrainersModel trainersModel;
      trainersModel = TrainersModel.fromJson(data);
      return right(trainersModel);

    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateTrainerModel>> fetchUpdateTrainer({
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
      dataMap['gender'] = gender;
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
        endPoint: '/secretary/trainer/updateTrainer/$id',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      UpdateTrainerModel updateTrainerModel;
      updateTrainerModel = UpdateTrainerModel.fromJson(data);

      return right(updateTrainerModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteTrainerModel>> fetchDeleteTrainer({required int id}) async {
    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/trainer/deleteTrainer/$id',
        data: {
          "id": id,
        },
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DeleteTrainerModel deleteTrainerModel;
      deleteTrainerModel = DeleteTrainerModel.fromJson(data);

      return right(deleteTrainerModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsTrainerModel>> fetchDetailsTrainer({required int id}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/trainer/showTrainerById/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DetailsTrainerModel detailsTrainerModel;
      detailsTrainerModel = DetailsTrainerModel.fromJson(data);

      return right(detailsTrainerModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchTrainerModel>> fetchSearchTrainer({required String querySearch, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/trainer/searchTrainer/$querySearch?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      SearchTrainerModel searchTrainerModel;
      searchTrainerModel = SearchTrainerModel.fromJson(data);

      return right(searchTrainerModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ArchiveSectionTrainerModel>> fetchArchiveTrainer({required int id, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/section/getTrainerArchive/$id?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      ArchiveSectionTrainerModel archiveSectionTrainerModel;
      archiveSectionTrainerModel = ArchiveSectionTrainerModel.fromJson(data);

      return right(archiveSectionTrainerModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}