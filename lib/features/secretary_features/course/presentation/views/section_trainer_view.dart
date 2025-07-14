import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/delete_section_trainer_cubit/delete_section_trainer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/course_repo_impl.dart';
import '../manager/trainers_section_cubit/trainers_section_cubit.dart';
import 'widgets/section_trainer_view_body.dart';

class SectionTrainerView extends StatelessWidget {
  const SectionTrainerView({super.key, required this.departmentId, required this.sectionId});

  final int departmentId;
  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return TrainersSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchTrainersSection(id: sectionId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteSectionTrainerCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
      ],
      child: SectionTrainerViewBody(departmentId: departmentId, sectionId: sectionId,),
    );
  }
}
