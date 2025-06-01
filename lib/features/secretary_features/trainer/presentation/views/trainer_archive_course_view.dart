import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import 'widgets/trainer_archive_course_view_body.dart';

class TrainerArchiveCourseView extends StatelessWidget {
  const TrainerArchiveCourseView({super.key, required this.trainerId});

  final int trainerId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return StudentsSectionCubit(
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
      ],
      child: TrainerArchiveCourseViewBody(),
    );
  }
}
