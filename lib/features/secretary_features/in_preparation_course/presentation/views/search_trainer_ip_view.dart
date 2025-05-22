import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/add_section_trainer_cubit/add_section_trainer_cubit.dart';
import '../../../trainer/data/repos/trainer_repo_impl.dart';
import '../../../trainer/presentation/manager/search_trainer_cubit/search_trainer_cubit.dart';
import 'widgets/search_trainer_ip_view_body.dart';

class SearchTrainerIpView extends StatelessWidget {
  const SearchTrainerIpView({super.key, required this.sectionId});

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
      child: SearchTrainerIpViewBody(sectionId: sectionId,),
    );
  }
}
