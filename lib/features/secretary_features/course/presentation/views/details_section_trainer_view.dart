import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../trainer/data/repos/trainer_repo_impl.dart';
import '../../../trainer/presentation/manager/archive_trainer_cubit/archive_trainer_cubit.dart';
import '../../../trainer/presentation/manager/details_trainer_cubit/details_trainer_cubit.dart';
import '../../data/repos/course_repo_impl.dart';
import '../manager/trainer_rating_cubit/trainer_rating_cubit.dart';
import 'widgets/details_section_trainer_view_body.dart';

class DetailsSectionTrainerView extends StatefulWidget {
  const DetailsSectionTrainerView({super.key, required this.departmentId, required this.id, required this.sectionId, required this.courseId});

  final int departmentId;
  final int sectionId;
  final int courseId;
  final int id;

  @override
  State<DetailsSectionTrainerView> createState() => _DetailsSectionTrainerViewState();
}

class _DetailsSectionTrainerViewState extends State<DetailsSectionTrainerView> {
  late final DetailsTrainerCubit _cubit;
  late final ArchiveTrainerCubit _archiveCubit;
  late int _currentId;

  @override
  void initState() {
    super.initState();
    _cubit = DetailsTrainerCubit(getIt.get<TrainerRepoImpl>());
    _archiveCubit = ArchiveTrainerCubit(getIt.get<TrainerRepoImpl>());
    _currentId = widget.id;
    _cubit.fetchDetailsTrainer(id: _currentId);
    _archiveCubit.fetchArchiveTrainer(id: _currentId, page: 1);
  }

  @override
  void didUpdateWidget(covariant DetailsSectionTrainerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _currentId = widget.id;
      _cubit.fetchDetailsTrainer(id: _currentId);
      _archiveCubit.fetchArchiveTrainer(id: _currentId, page: 1);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    _archiveCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _cubit,
        ),
        BlocProvider(
          create: (context) {
            return TrainerRatingCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchTrainerRating(trainerId: widget.id, sectionId: widget.sectionId);
          },
        ),
        BlocProvider.value(
          value: _archiveCubit,
        ),
      ],
      child: DetailsSectionTrainerViewBody(departmentId: widget.departmentId, courseId: widget.courseId, sectionId: widget.sectionId, trainerId: widget.id,),

    );
  }
}
