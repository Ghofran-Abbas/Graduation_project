import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/details_course_cubit/details_course_cubit.dart';
import '../../../course/presentation/manager/files_cubit/files_cubit.dart';
import '../../../course/presentation/manager/section_progress_cubit/section_progress_cubit.dart';
import '../../../course/presentation/manager/section_rating_cubit/section_rating_cubit.dart';
import '../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../report/data/repos/report_repo_impl.dart';
import '../../../report/presentation/manager/get_file_cubit/get_file_cubit.dart';
import '../manager/complete_cubit/complete_cubit.dart';
import 'widgets/complete_details_view_body.dart';

class CompleteDetailsView extends StatelessWidget {
  const CompleteDetailsView({super.key, required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
            return DetailsCourseCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchDetailsCourse(id: courseId);
          },
        ),
        BlocProvider(
          create: (context) {
            return CompleteCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchComplete(courseId: courseId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return SelectCompleteCubit(
              getIt.get<CourseRepoImpl>(),
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
      child: CompleteDetailsViewBody(courseId: courseId,),
    );
  }
}
