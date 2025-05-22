import 'package:alhadara_dashboard/features/profile/presentaion/views/widgets/profile_view_body.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/data/repos/department_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/presentation/manager/departments_cubit/departments_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/logout/data/repos/logout_secretary_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/logout/presentation/manager/logout_secretary_cubit/logout_secretary_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/repos/student_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/trainers_cubit/trainers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/localization/app_localizations_setup.dart';
import 'core/localization/local_cubit/local_cubit.dart';
import 'core/utils/app_router.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/service_locator.dart';
import 'features/login/data/repos/login_secretary_repo_impl.dart';
import 'features/login/presentation/manager/login_cubit/login_secretary_cubit.dart';
import 'features/secretary_features/student/presentation/manager/students_cubit/students_cubit.dart';

void main() {

  setupServiceLocator();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(create: (_) => LocaleCubit()),
        BlocProvider(
          create: (context) {
            return LoginCubit(
              getIt.get<LoginRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return UserCubit(
              //getIt.get<LoginRepoImpl>(),
            )..loadUser();
          },
        ),
        BlocProvider(
          create: (context) {
            return LogoutSecretaryCubit(
              getIt.get<LogoutSecretaryRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DepartmentsCubit(
              getIt.get<DepartmentRepoImpl>(),
            )..fetchDepartments(page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return StudentsCubit(
              getIt.get<StudentRepoImpl>(),
            )..fetchStudents(page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return TrainersCubit(
              getIt.get<TrainerRepoImpl>(),
            )..fetchTrainers(page: 1);
          },
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
            designSize: const Size(1440, 1024),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                routerDelegate: AppRouter.router.routerDelegate,
                routeInformationParser: AppRouter.router.routeInformationParser,
                routeInformationProvider: AppRouter.router.routeInformationProvider,
                debugShowCheckedModeBanner: false,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
                localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
                locale: locale,
              );
            },
          );
        },
      ),
    );
  }
}