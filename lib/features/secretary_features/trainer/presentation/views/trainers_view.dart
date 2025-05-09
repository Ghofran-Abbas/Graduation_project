import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/create_trainer_cubit/create_trainer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/delete_trainer_cubit/delete_trainer_cubit.dart';
import '../manager/update_trainer_cubit/update_trainer_cubit.dart';
import 'widgets/trainers_view_body.dart';

class TrainersView extends StatelessWidget {
  const TrainersView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return CreateTrainerCubit(
              getIt.get<TrainerRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return UpdateTrainerCubit(
              getIt.get<TrainerRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteTrainerCubit(
              getIt.get<TrainerRepoImpl>(),
            );
          },
        ),
      ],
      child: TrainersViewBody(),
    );
  }
}
