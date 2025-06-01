import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/details_trainer_cubit/details_trainer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/trainer_details_view_body.dart';

class TrainerDetailsView extends StatefulWidget {
  const TrainerDetailsView({super.key, required this.id});

  final int id;

  @override
  State<TrainerDetailsView> createState() => _TrainerDetailsViewState();
}

class _TrainerDetailsViewState extends State<TrainerDetailsView> {
  late final DetailsTrainerCubit _cubit;
  late int _currentId;

  @override
  void initState() {
    super.initState();
    _cubit = DetailsTrainerCubit(getIt.get<TrainerRepoImpl>());
    _currentId = widget.id;
    _cubit.fetchDetailsTrainer(id: _currentId);
  }

  @override
  void didUpdateWidget(covariant TrainerDetailsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _currentId = widget.id;
      _cubit.fetchDetailsTrainer(id: _currentId);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: const TrainerDetailsViewBody(),
    );
  }
}

