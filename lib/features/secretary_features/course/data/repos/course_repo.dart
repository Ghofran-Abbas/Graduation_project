import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/course/data/models/add_section_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/courses_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/create_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/create_section_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/delete_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/delete_section_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/details_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/details_section_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/files_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/search_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/trainer_rating_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/update_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/in_preparation_course/data/models/in_preparation_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/search_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/sections_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/trainers_section_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/update_section_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../complete_course/data/models/complete_model.dart';
import '../models/add_section_student_model.dart';
import '../models/all_courses_model.dart';
import '../models/confirm_reservation_student_model.dart';
import '../models/delete_section_student_model.dart';
import '../models/delete_section_trainer_model.dart';
import '../models/confirmed_students_section_model.dart';
import '../models/reservation_students_section_model.dart';
import '../models/section_progress_model.dart';
import '../models/section_rating_model.dart';
import '../models/students_section_model.dart';
import '../models/update_state_section_model.dart';

abstract class CourseRepo {

  Future<Either<Failure, CoursesModel>> fetchCourses({required int departmentId, required int page});

  Future<Either<Failure, CreateCourseModel>> fetchCreateCourse({
    required int departmentId,
    required String name,
    required String description,
    required Uint8List photo,
  });

  Future<Either<Failure, DetailsCourseModel>> fetchDetailsCourse({
    required int id,
  });

  Future<Either<Failure, UpdateCourseModel>> fetchUpdateCourse({
    required int id,
    required int departmentId,
    String? name,
    String? description,
    Uint8List? photo,
  });

  Future<Either<Failure, DeleteCourseModel>> fetchDeleteCourse({
    required int id,
  });

  Future<Either<Failure, SearchCourseModel>> fetchSearchCourse({required String querySearch, required int page});


  Future<Either<Failure, SectionsModel>> fetchSections({
    required int id,
    required int page,
  });

  Future<Either<Failure, CreateSectionModel>> fetchCreateSection({
    required int courseId,
    required String name,
    required String state,
    required int seatsOfNumber,
    required int totalSessions,
    required String startDate,
    required String endDate,
    required Map<String, dynamic>? sunday,
    required Map<String, dynamic>? monday,
    required Map<String, dynamic>? tuesday,
    required Map<String, dynamic>? wednesday,
    required Map<String, dynamic>? thursday,
    required Map<String, dynamic>? friday,
    required Map<String, dynamic>? saturday,
  });

  Future<Either<Failure, UpdateSectionModel>> fetchUpdateSection({
    required int courseId,
    String? name,
    int? seatsOfNumber,
    int? totalSessions,
    String? startDate,
    String? endDate,
    String? state,
    Map<String, dynamic>? sunday,
    Map<String, dynamic>? monday,
    Map<String, dynamic>? tuesday,
    Map<String, dynamic>? wednesday,
    Map<String, dynamic>? thursday,
    Map<String, dynamic>? friday,
    Map<String, dynamic>? saturday,
  });

  Future<Either<Failure, DeleteSectionModel>> fetchDeleteSection({
    required int id,
  });

  Future<Either<Failure, DetailsSectionModel>> fetchDetailsSection({
    required int id,
  });


  Future<Either<Failure, TrainersSectionModel>> fetchTrainersSection({required int id, required int page});

  Future<Either<Failure, AddSectionTrainerModel>> fetchAddSectionTrainer({
    required int sectionId,
    required int trainerId,
  });

  Future<Either<Failure, DeleteSectionTrainerModel>> fetchDeleteSectionTrainer({
    required int sectionId,
    required int trainerId,
  });

  Future<Either<Failure, StudentsSectionModel>> fetchStudentsSection({required int id, required int page});

  Future<Either<Failure, ConfirmedStudentsSectionModel>> fetchConfirmedStudentsSection({required int id, required int page});

  Future<Either<Failure, ReservationStudentsSectionModel>> fetchReservationStudentsSection({required int id, required int page});

  Future<Either<Failure, ConfirmReservationStudentModel>> fetchConfirmReservationStudent({required int reservationId,});

  Future<Either<Failure, AddSectionStudentModel>> fetchAddSectionStudent({
    required int sectionId,
    required int studentId,
  });

  Future<Either<Failure, DeleteSectionStudentModel>> fetchDeleteSectionStudent({
    required int sectionId,
    required int studentId,
  });

  Future<Either<Failure, FilesModel>> fetchFiles({required int sectionId, required int page});

  Future<Either<Failure, SectionRatingModel>> fetchSectionRating({required int sectionId});

  Future<Either<Failure, TrainerRatingModel>> fetchTrainerRating({required int trainerId, required int sectionId});

  Future<Either<Failure, InPreparationModel>> fetchPendingSection({required int courseId, required int page});

  Future<Either<Failure, AllCoursesModel>> fetchAllCourses({required int page});

  Future<Either<Failure, SectionProgressModel>> fetchSectionProgress({required int sectionId});

  Future<Either<Failure, CompleteModel>> fetchFinishedSection({required int courseId, required int page});

  Future<Either<Failure, UpdateStateSectionModel>> fetchUpdateStateSection({required int courseId, String? state,});
}