import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/trainer_repo_impl.dart';
import '../manager/search_trainer_cubit/search_trainer_cubit.dart';
import 'widgets/search_trainer_view_body.dart';

class SearchTrainerView extends StatelessWidget {
  const SearchTrainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchTrainerCubit(
          getIt.get<TrainerRepoImpl>(),
        );
      },
      child: SearchTrainerViewBody(),
    );
  }
}
