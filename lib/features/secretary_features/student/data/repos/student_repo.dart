import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/student/data/models/archive_section_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/create_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/delete_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/details_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/search_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/update_student_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../models/students_model.dart';

abstract class StudentRepo {

  Future<Either<Failure, StudentsModel>> fetchStudents({required int page});

  Future<Either<Failure, CreateStudentModel>> fetchCreateStudent({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String birthday,
    required String gender,
    int? referredId,
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

  Future<Either<Failure, DeleteStudentModel>> fetchDeleteStudent({
    required int id,
  });

  Future<Either<Failure, DetailsStudentModel>> fetchDetailsStudent({
    required int id,
  });

  Future<Either<Failure, SearchStudentModel>> fetchSearchStudent({required String querySearch, required int page});

  Future<Either<Failure, ArchiveSectionStudentModel>> fetchArchiveStudent({required int id, required int page});
}