import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/constants.dart';
import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/add_section_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/add_section_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/all_courses_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/courses_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/create_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/delete_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/delete_section_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/delete_section_student_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/delete_section_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/details_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/files_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/reservation_students_section_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/search_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/confirmed_students_section_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/section_progress_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/section_rating_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/trainer_rating_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/update_course_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/in_preparation_course/data/models/in_preparation_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/search_trainer_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/sections_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/trainers_section_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/models/update_section_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/shared_preferences_helper.dart';
import '../models/confirm_reservation_student_model.dart';
import '../models/create_section_model.dart';
import '../models/details_section_model.dart';
import '../models/students_section_model.dart';
import 'course_repo.dart';

class CourseRepoImpl implements CourseRepo {
  final DioApiService dioApiService;
  static var dio = Dio();

  CourseRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, CoursesModel>> fetchCourses({required int departmentId, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/departments/$departmentId/courses?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      CoursesModel coursesModel;
      coursesModel = CoursesModel.fromJson(data);

      return right(coursesModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateCourseModel>> fetchCreateCourse({
    required int departmentId,
    required String name,
    required String description,
    required Uint8List photo,
  }) async {
    FormData formData = FormData.fromMap({
      "department_id": departmentId,
      "name": name,
      "description": description,
      "state": 'not_start',
      "photo": MultipartFile.fromBytes(
        photo,
        filename: 'upload.png',
      ),
    });

    try {
      var data = await (dioApiService.postWithImage(
        endPoint: '/secretary/courses',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      CreateCourseModel createCourseModel;
      createCourseModel = CreateCourseModel.fromJson(data);

      return right(createCourseModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsCourseModel>> fetchDetailsCourse({required int id}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/courses/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DetailsCourseModel detailsCourseModel;
      detailsCourseModel = DetailsCourseModel.fromJson(data);

      return right(detailsCourseModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateCourseModel>> fetchUpdateCourse({
    required int id,
    required int departmentId,
    String? name,
    String? description,
    Uint8List? photo,
  }) async {
    final Map<String, dynamic> dataMap = {};

    if (name != null && name.trim().isNotEmpty) {
      dataMap['name'] = name;
    }

    if (description != null && description.trim().isNotEmpty) {
      dataMap['description'] = description;
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
        endPoint: '/secretary/courses/$id',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      UpdateCourseModel updateCourseModel;
      updateCourseModel = UpdateCourseModel.fromJson(data);

      return right(updateCourseModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteCourseModel>> fetchDeleteCourse({required int id}) async {
    try {
      var data = await (dioApiService.delete(
        endPoint: '/secretary/courses/$id',
        data: {},
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DeleteCourseModel deleteCourseModel;
      deleteCourseModel = DeleteCourseModel.fromJson(data);

      return right(deleteCourseModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchCourseModel>> fetchSearchCourse({required String querySearch, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/searchCourses/$querySearch?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      SearchCourseModel searchCourseModel;
      searchCourseModel = SearchCourseModel.fromJson(data);

      return right(searchCourseModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsSectionModel>> fetchDetailsSection({
    required int id,
  }) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/section/ShowByIdCourseSection/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DetailsSectionModel detailsSectionModel;
      detailsSectionModel = DetailsSectionModel.fromJson(data);

      return right(detailsSectionModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, SectionsModel>> fetchSections({
    required int id,
    required int page,
  }) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/section/showAllCourseSection/$id?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      SectionsModel sectionsModel;
      sectionsModel = SectionsModel.fromJson(data);

      return right(sectionsModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
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
  }) async {
    final Map<String, dynamic> days = {};
    if (sunday != null && sunday['start_time'].trim().isNotEmpty && sunday['end_time'].trim().isNotEmpty) {
      days['sunday'] = sunday;
    }
    if (monday != null && monday['start_time'].trim().isNotEmpty && monday['end_time'].trim().isNotEmpty) {
      days['monday'] = monday;
    }
    if (tuesday != null && tuesday['start_time'].trim().isNotEmpty && tuesday['end_time'].trim().isNotEmpty) {
      days['tuesday'] = tuesday;
    }
    if (wednesday != null && wednesday['start_time'].trim().isNotEmpty && wednesday['end_time'].trim().isNotEmpty) {
      days['wednesday'] = wednesday;
    }
    if (thursday != null && thursday['start_time'].trim().isNotEmpty && thursday['end_time'].trim().isNotEmpty) {
      days['thursday'] = thursday;
    }
    if (friday != null && friday['start_time'].trim().isNotEmpty && friday['end_time'].trim().isNotEmpty) {
      days['friday'] = friday;
    }
    if (saturday != null && saturday['start_time'].trim().isNotEmpty && saturday['end_time'].trim().isNotEmpty) {
      days['saturday'] = saturday;
    }
    if (days.isEmpty) {
      return left(ServerFailure('يجب اختيار يوم واحد على الأقل قبل الإرسال.'));
    }

    log(days.toString());
    log('DAYS JSON: ${jsonEncode(days)}');
    final Map<String, dynamic> da = {
      "courseId": courseId,
      "name": name,
      "state": state,
      "seatsOfNumber": seatsOfNumber,
      "total_sessions": totalSessions,
      "startDate": startDate,
      "endDate": endDate,
      "days": days,
    };
    log(da.toString());

    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/section/createCourseSection',
        data: {
          "courseId": courseId,
          "name": name,
          "state": state,
          "seatsOfNumber": seatsOfNumber,
          "total_sessions": totalSessions,
          "startDate": startDate,
          "endDate": endDate,
          "days": days,
        },
        token: await SharedPreferencesHelper.getJwtToken(),
      ));

      log(data.toString());
      CreateSectionModel createSectionModel;
      createSectionModel = CreateSectionModel.fromJson(data);

      return right(createSectionModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateSectionModel>> fetchUpdateSection({
    required int courseId,
    String? name,
    String? state,
    int? seatsOfNumber,
    int? totalSessions,
    String? startDate,
    String? endDate,
    Map<String, dynamic>? sunday,
    Map<String, dynamic>? monday,
    Map<String, dynamic>? tuesday,
    Map<String, dynamic>? wednesday,
    Map<String, dynamic>? thursday,
    Map<String, dynamic>? friday,
    Map<String, dynamic>? saturday,
  }) async {
    final Map<String, dynamic> days = {};
    if (sunday != null && sunday['start_time'].trim().isNotEmpty && sunday['end_time'].trim().isNotEmpty) {
      days['sunday'] = sunday;
    }
    if (monday != null && monday['start_time'].trim().isNotEmpty && monday['end_time'].trim().isNotEmpty) {
      days['monday'] = monday;
    }
    if (tuesday != null && tuesday['start_time'].trim().isNotEmpty && tuesday['end_time'].trim().isNotEmpty) {
      days['tuesday'] = tuesday;
    }
    if (wednesday != null && wednesday['start_time'].trim().isNotEmpty && wednesday['end_time'].trim().isNotEmpty) {
      days['wednesday'] = wednesday;
    }
    if (thursday != null && thursday['start_time'].trim().isNotEmpty && thursday['end_time'].trim().isNotEmpty) {
      days['thursday'] = thursday;
    }
    if (friday != null && friday['start_time'].trim().isNotEmpty && friday['end_time'].trim().isNotEmpty) {
      days['friday'] = friday;
    }
    if (saturday != null && saturday['start_time'].trim().isNotEmpty && saturday['end_time'].trim().isNotEmpty) {
      days['saturday'] = saturday;
    }
    log(days.toString());
    log('DAYS JSON: ${jsonEncode(days)}');

    final Map<String, dynamic> updateData = {};

    if (name != null && name.trim().isNotEmpty) {
      updateData['name'] = name;
    }
    if (seatsOfNumber != null && seatsOfNumber.toString().trim().isNotEmpty) {
      updateData['seatsOfNumber'] = seatsOfNumber;
    }
    if (totalSessions != null && totalSessions.toString().trim().isNotEmpty) {
      updateData['total_sessions'] = totalSessions;
    }
    if (startDate != null && startDate.trim().isNotEmpty) {
      updateData['startDate'] = startDate;
    }
    if (endDate != null && endDate.trim().isNotEmpty) {
      updateData['endDate'] = endDate;
    }
    if (state != null && state.trim().isNotEmpty) {
      if(state == 'Pending') {
        updateData['state'] = 'pending';
      } else if(state == 'In progress') {
        updateData['state'] = 'in_progress';
      } else if(state == 'Finished') {
        updateData['state'] = 'finished';
      } else {
        updateData['state'] = state;
      }
    }
    if (days.isNotEmpty) {
      updateData['days'] = days;
    }

    if (updateData.isEmpty) {
      return left(ServerFailure('يجب ادخال حقل واحد على الأقل قبل الإرسال.'));
    }

    log("Update data is: ${updateData.toString()}");

    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/section/updateCourseSection/$courseId',
        data: updateData,
        token: await SharedPreferencesHelper.getJwtToken(),
      ));

      log(data.toString());
      UpdateSectionModel updateSectionModel;
      updateSectionModel = UpdateSectionModel.fromJson(data);

      return right(updateSectionModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteSectionModel>> fetchDeleteSection({required int id}) async {
    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/section/deleteCourseSection/$id',
        data: {},
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DeleteSectionModel deleteSectionModel;
      deleteSectionModel = DeleteSectionModel.fromJson(data);

      return right(deleteSectionModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, TrainersSectionModel>> fetchTrainersSection({required int id, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/section/getTrainersInSection/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      TrainersSectionModel trainersSectionModel;
      trainersSectionModel = TrainersSectionModel.fromJson(data);

      return right(trainersSectionModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddSectionTrainerModel>> fetchAddSectionTrainer({
    required int sectionId,
    required int trainerId,
  }) async {

    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/section/registerTrainerToSection',
        data: {
          "course_section_id": sectionId,
          "trainer_id": trainerId,
        },
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      AddSectionTrainerModel addSectionTrainerModel;
      addSectionTrainerModel = AddSectionTrainerModel.fromJson(data);

      return right(addSectionTrainerModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteSectionTrainerModel>> fetchDeleteSectionTrainer({
    required int sectionId,
    required int trainerId,
  }) async {

    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/section/deleteTrainerFromSection',
        data: {
          "course_section_id": sectionId,
          "trainer_id": trainerId,
        },
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DeleteSectionTrainerModel deleteSectionTrainerModel;
      deleteSectionTrainerModel = DeleteSectionTrainerModel.fromJson(data);

      return right(deleteSectionTrainerModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentsSectionModel>> fetchStudentsSection({required int id, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/section/getStudentsInSection/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      StudentsSectionModel studentsSectionModel;
      studentsSectionModel = StudentsSectionModel.fromJson(data);

      return right(studentsSectionModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConfirmedStudentsSectionModel>> fetchConfirmedStudentsSection({required int id, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/section/getStudentsInSectionConfirmed/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      ConfirmedStudentsSectionModel confirmedStudentsSectionModel;
      confirmedStudentsSectionModel = ConfirmedStudentsSectionModel.fromJson(data);

      return right(confirmedStudentsSectionModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReservationStudentsSectionModel>> fetchReservationStudentsSection({required int id, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/reservation/showAllReservation/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      ReservationStudentsSectionModel reservationStudentsSectionModel;
      reservationStudentsSectionModel = ReservationStudentsSectionModel.fromJson(data);

      return right(reservationStudentsSectionModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConfirmReservationStudentModel>> fetchConfirmReservationStudent({required int reservationId}) async {

    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/reservation/confirmReservation/$reservationId',
        data: {},
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      ConfirmReservationStudentModel confirmReservationStudentModel;
      confirmReservationStudentModel = ConfirmReservationStudentModel.fromJson(data);

      return right(confirmReservationStudentModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddSectionStudentModel>> fetchAddSectionStudent({
    required int sectionId,
    required int studentId,
  }) async {
    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/section/registerStudentToSection',
        data: {
          "course_section_id": sectionId,
          "student_id": studentId,
        },
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      AddSectionStudentModel addSectionStudentModel;
      addSectionStudentModel = AddSectionStudentModel.fromJson(data);

      return right(addSectionStudentModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteSectionStudentModel>> fetchDeleteSectionStudent({required int sectionId, required int studentId,}) async {

    try {
      var data = await (dioApiService.post(
        endPoint: '/secretary/section/deleteStudentFromSection',
        data: {
          "course_section_id": sectionId,
          "student_id": studentId,
        },
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      DeleteSectionStudentModel deleteSectionStudentModel;
      deleteSectionStudentModel = DeleteSectionStudentModel.fromJson(data);

      return right(deleteSectionStudentModel);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FilesModel>> fetchFiles({required int sectionId, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/file/showAllFileInSection/$sectionId?page=$page',
        //token: await SharedPreferencesHelper.getJwtToken(),
        token: Constants.trainerToken,
      ));
      log(data.toString());
      FilesModel filesModel;
      filesModel = FilesModel.fromJson(data);

      return right(filesModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainerRatingModel>> fetchTrainerRating({required int trainerId, required int sectionId}) async {
    try {
      var data = await (dioApiService.get(
          endPoint: '/trainer-rating/$trainerId/section/$sectionId/ratings',
          token: await SharedPreferencesHelper.getJwtToken(),
      ));
    log(data.toString());
      TrainerRatingModel trainerRatingModel;
    trainerRatingModel = TrainerRatingModel.fromJson(data);

    return right(trainerRatingModel);
    } catch (e) {
    if (e is DioException){
    return left(ServerFailure.fromDioError(e),);
    }
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SectionRatingModel>> fetchSectionRating({required int sectionId}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/section-rating/$sectionId/ratings',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      SectionRatingModel sectionRatingModel;
      sectionRatingModel = SectionRatingModel.fromJson(data);

      return right(sectionRatingModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, InPreparationModel>> fetchPendingSection({required int courseId, required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/section/showAllCourseSectionIsPending/$courseId/?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      InPreparationModel inPreparationModel;
      inPreparationModel = InPreparationModel.fromJson(data);

      return right(inPreparationModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AllCoursesModel>> fetchAllCourses({required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/courses?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      AllCoursesModel allCoursesModel;
      allCoursesModel = AllCoursesModel.fromJson(data);

      return right(allCoursesModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SectionProgressModel>> fetchSectionProgress({required int sectionId}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/course-sections/$sectionId/progress',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      SectionProgressModel sectionProgressModel;
      sectionProgressModel = SectionProgressModel.fromJson(data);

      return right(sectionProgressModel);
    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}