import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/details_course_cubit/details_course_cubit.dart';
import '../../../course/presentation/manager/details_section_cubit/details_section_cubit.dart';
import '../../../course/presentation/manager/files_cubit/files_cubit.dart';
import '../../../course/presentation/manager/section_progress_cubit/section_progress_cubit.dart';
import '../../../course/presentation/manager/section_rating_cubit/section_rating_cubit.dart';
import '../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../report/data/repos/report_repo_impl.dart';
import '../../../report/presentation/manager/get_file_cubit/get_file_cubit.dart';
import 'widgets/archive_section_trainer_view_body.dart';

class ArchiveSectionTrainerView extends StatelessWidget {
  const ArchiveSectionTrainerView({super.key, required this.sectionId, required this.courseId, required this.trainerId});

  final int sectionId;
  final int courseId;
  final int trainerId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return StudentsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchStudentsSection(id: sectionId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return TrainersSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchTrainersSection(id: sectionId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return FilesCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchFiles(sectionId: sectionId, page: 1);
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
            return DetailsCourseCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchDetailsCourse(id: courseId);
          },
        ),
        BlocProvider(
          create: (context) {
            return DetailsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchDetailsSection(id: sectionId);
          },
        ),
        BlocProvider(
          create: (context) {
            return SectionRatingCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchSectionRating(sectionId: sectionId);
          },
        ),
        BlocProvider(
          create: (context) {
            return SectionProgressCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchSectionProgress(sectionId: sectionId);
          },
        ),
      ],
      child: ArchiveSectionTrainerViewBody(sectionId: sectionId, trainerId: trainerId,),
    );
  }
}
