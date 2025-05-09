import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/details_trainer_cubit/details_trainer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/trainer_details_view_body.dart';

class TrainerDetailsView extends StatelessWidget {
  const TrainerDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DetailsTrainerCubit(
          getIt.get<TrainerRepoImpl>(),
        )..fetchDetailsTrainer(id: id);
      },
      child: const TrainerDetailsViewBody(),
    );
  }
}
