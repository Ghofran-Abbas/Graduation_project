import 'package:dio/dio.dart';

import '../../../../../core/utils/api_service.dart';
import 'course_repo.dart';

class CourseRepoImpl implements CourseRepo {
  final DioApiService dioApiService;
  static var dio = Dio();

  CourseRepoImpl(this.dioApiService);
}