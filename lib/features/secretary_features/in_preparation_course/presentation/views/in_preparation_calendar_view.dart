import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/details_section_cubit/details_section_cubit.dart';
import 'widgets/in_preparation_calendar_view_body.dart';

class InPreparationCalendarView extends StatelessWidget {
  const InPreparationCalendarView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DetailsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchDetailsSection(id: sectionId);
          },
        ),
      ],
      child: InPreparationCalendarViewBody(),
    );
  }
}
