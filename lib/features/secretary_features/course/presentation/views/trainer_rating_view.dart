import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/course_repo_impl.dart';
import '../manager/trainer_rating_cubit/trainer_rating_cubit.dart';
import 'widgets/trainer_rating_view_body.dart';

class TrainerRatingView extends StatelessWidget {
  const TrainerRatingView({super.key, required this.trainerId, required this.sectionId});

  final int trainerId;
  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TrainerRatingCubit(
          getIt.get<CourseRepoImpl>(),
        )..fetchTrainerRating(trainerId: trainerId, sectionId: sectionId);
      },
      child: TrainerRatingViewBody(),
    );
  }
}
