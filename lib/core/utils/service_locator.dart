import 'package:alhadara_dashboard/features/login/data/repos/login_secretary_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/data/repos/department_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/logout/data/repos/logout_secretary_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/data/repos/report_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/repos/student_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/profile/data/repos/profile_repo_impl.dart';
import '../../features/secretary_features/course/data/repos/course_repo_impl.dart';
import '../../features/secretary_features/forgot_password/data/repos/forgot_password_repo_impl.dart';
import '../../features/secretary_features/notification/data/repos/notification_repo_impl.dart';
import '../../features/secretary_features/password_reset/data/repos/password_reset_repo_impl.dart';
import '../../features/secretary_features/task/data/repos/task_repo_impl.dart';
import '../../features/secretary_features/verification/data/repos/verification_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {

  getIt.registerSingleton<DioApiService>(
    DioApiService(
        Dio(),
    ),
  );

  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<LogoutSecretaryRepoImpl>(
    LogoutSecretaryRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<VerificationRepoImpl>(
    VerificationRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<ForgotPasswordRepoImpl>(
    ForgotPasswordRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<PasswordResetRepoImpl>(
    PasswordResetRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<DepartmentRepoImpl>(
    DepartmentRepoImpl(
        getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<CourseRepoImpl>(
    CourseRepoImpl(
        getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<StudentRepoImpl>(
    StudentRepoImpl(
        getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<TrainerRepoImpl>(
    TrainerRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<ReportRepoImpl>(
    ReportRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<TaskRepoImpl>(
    TaskRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );

  getIt.registerSingleton<NotificationRepoImpl>(
    NotificationRepoImpl(
      getIt.get<DioApiService>(),
    ),
  );
}