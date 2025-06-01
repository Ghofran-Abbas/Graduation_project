import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/files_cubit/files_cubit.dart';
import '../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../report/data/repos/report_repo_impl.dart';
import '../../../report/presentation/manager/get_file_cubit/get_file_cubit.dart';
import 'widgets/archive_section_trainer_view_body.dart';

class ArchiveSectionTrainerView extends StatelessWidget {
  const ArchiveSectionTrainerView({super.key, required this.sectionId});

  final int sectionId;

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
      ],
      child: ArchiveSectionTrainerViewBody(sectionId: sectionId,),
    );
  }
}
