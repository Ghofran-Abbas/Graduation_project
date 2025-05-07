import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/create_trainer_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/trainers_model.dart';

abstract class TrainerRepo {
  Future<Either<Failure, TrainersModel>> fetchTrainers();

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
  });
}