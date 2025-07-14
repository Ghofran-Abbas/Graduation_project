import 'dart:developer';

import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/repos/course_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/sections_cubit/sections_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../report/data/repos/report_repo_impl.dart';
import '../../../report/presentation/manager/get_file_cubit/get_file_cubit.dart';
import '../manager/confirmed_students_section_cubit/confirmed_students_section_cubit.dart';
import '../manager/create_section_cubit/create_section_cubit.dart';
import '../manager/delete_section_cubit/delete_section_cubit.dart';
import '../manager/details_course_cubit/details_course_cubit.dart';
import '../manager/files_cubit/files_cubit.dart';
import '../manager/section_progress_cubit/section_progress_cubit.dart';
import '../manager/section_rating_cubit/section_rating_cubit.dart';
import '../manager/students_section_cubit/students_section_cubit.dart';
import '../manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../manager/update_section_cubit/update_section_cubit.dart';
import 'widgets/course_details_view_body.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key, required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return CreateSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return UpdateSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DetailsCourseCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchDetailsCourse(id: courseId);
          },
        ),
        BlocProvider(
          create: (context) {
            return SectionsCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchSections(id: courseId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return SelectSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return TrainersSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return StudentsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return FilesCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return GetFileCubit(
              getIt.get<ReportRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return SectionRatingCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return SectionProgressCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
      ],
      child: CourseDetailsViewBody(courseId: courseId,),
    );
  }
}
