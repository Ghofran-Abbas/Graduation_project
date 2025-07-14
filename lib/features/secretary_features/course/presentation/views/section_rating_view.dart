import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../data/repos/course_repo_impl.dart';
import '../manager/section_rating_cubit/section_rating_cubit.dart';
import 'widgets/section_rating_view_body.dart';

class SectionRatingView extends StatelessWidget {
  const SectionRatingView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SectionRatingCubit(
          getIt.get<CourseRepoImpl>(),
        )..fetchSectionRating(sectionId: sectionId);
      },
      child: SectionRatingViewBody(sectionId: sectionId,),
    );
  }
}
