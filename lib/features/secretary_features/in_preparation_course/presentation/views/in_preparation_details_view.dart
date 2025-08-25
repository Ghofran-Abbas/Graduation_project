import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/delete_section_cubit/delete_section_cubit.dart';
import '../../../course/presentation/manager/details_course_cubit/details_course_cubit.dart';
import '../../../course/presentation/manager/sections_cubit/sections_cubit.dart';
import '../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../course/presentation/manager/update_section_cubit/update_section_cubit.dart';
import '../../../course/presentation/manager/update_state_section_cubit/update_state_section_cubit.dart';
import '../manager/in_preparation_cubit/in_preparation_cubit.dart';
import 'widgets/in_preparation_details_view_body.dart';

class DetailsInPreparationView extends StatelessWidget {
  const DetailsInPreparationView({super.key, required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
            return InPreparationCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchInPreparation(courseId: courseId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return SelectInPreparationCubit(
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
            return UpdateStateSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
      ],
      child: DetailsInPreparationViewBody(courseId: courseId,),
    );
  }
}
