import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/delete_section_trainer_cubit/delete_section_trainer_cubit.dart';
import '../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import 'widgets/in_preparation_trainers_view_body.dart';

class InPreparationTrainersView extends StatelessWidget {
  const InPreparationTrainersView({super.key, required this.sectionId});

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
      child: InPreparationTrainersViewBody(sectionId: sectionId,),
    );
  }
}
