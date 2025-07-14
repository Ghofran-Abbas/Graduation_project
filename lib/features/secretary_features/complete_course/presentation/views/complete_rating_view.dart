import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/section_rating_cubit/section_rating_cubit.dart';
import 'widgets/complete_rating_view_body.dart';

class CompleteRatingView extends StatelessWidget {
  const CompleteRatingView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SectionRatingCubit(
          getIt.get<CourseRepoImpl>(),
        )..fetchSectionRating(sectionId: sectionId);
      },
      child: CompleteRatingViewBody(sectionId: sectionId,),
    );
  }
}