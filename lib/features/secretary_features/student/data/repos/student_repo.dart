import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/student/data/models/create_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/update_student_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/students_model.dart';

abstract class StudentRepo {

  Future<Either<Failure, StudentsModel>> fetchStudents();

  Future<Either<Failure, CreateStudentModel>> fetchCreateStudent({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required Uint8List photo,
  });

  Future<Either<Failure, UpdateStudentModel>> fetchUpdateStudent({
    required int id,
    String? name,
    String? phone,
    String? birthday,
    String? gender,
    Uint8List? photo,
  });

  /*Future<Either<Failure, DeleteStaffModel>> fetchDeleteStaff({
    required int id,
  });

  Future<Either<Failure, List<ShowStaffDetailsModel>>> fetchShowStaffDetails({
    required int id,
  });*/
}