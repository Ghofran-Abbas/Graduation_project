import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/secretary_features/course/data/repos/course_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<DioApiService>(
    DioApiService(
        Dio(),
    ),
  );
  getIt.registerSingleton<CourseRepoImpl>(
    CourseRepoImpl(
        getIt.get<DioApiService>(),
    ),
  );
}