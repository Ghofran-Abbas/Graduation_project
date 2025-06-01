import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/course/data/repos/course_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/courses_cubit/courses_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/create_course_cubit/create_course_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/delete_course_cubit/delete_course_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/search_course_cubit/search_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../department/data/repos/department_repo_impl.dart';
import '../../../department/presentation/manager/details_department_cubit/details_department_cubit.dart';
import '../manager/update_course_cubit/update_course_cubit.dart';
import 'widgets/courses_view_body.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({super.key, required this.departmentId});

  final int departmentId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DetailsDepartmentCubit(
              getIt.get<DepartmentRepoImpl>(),
            )..fetchDetailsDepartment(id: departmentId);
          },
        ),
        BlocProvider(
          create: (context) {
            return CreateCourseCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return CoursesCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchCourses(departmentId: departmentId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return UpdateCourseCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteCourseCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return SearchCourseCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
      ],
      child: CoursesViewBody(depId: departmentId,),
    );
  }
}
