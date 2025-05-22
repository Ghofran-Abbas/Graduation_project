import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/add_section_trainer_cubit/add_section_trainer_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../trainer/presentation/manager/search_trainer_cubit/search_trainer_cubit.dart';
import '../../data/repos/course_repo_impl.dart';
import 'widgets/search_trainer_section_view_body.dart';

class SearchTrainerSectionView extends StatelessWidget {
  const SearchTrainerSectionView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return SearchTrainerCubit(
              getIt.get<TrainerRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return AddSectionTrainerCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
      ],
      child: SearchTrainerSectionViewBody(sectionId: sectionId,),
    );
  }
}
