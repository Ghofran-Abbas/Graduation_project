import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/api_service.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/create_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/utils/shared_preferences_helper.dart';
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
  Future<Either<Failure, TrainersModel>> fetchTrainers() async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/trainer/showAllTrainer',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      TrainersModel trainersModel;
      trainersModel = TrainersModel.fromJson(data);
      List<DatumTrainer> allTrainers = [];
      for (var item in trainersModel.trainers.data!) {
        allTrainers.add(item);
      }
      return right(trainersModel);

    } catch (e) {
      if (e is DioError){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

}