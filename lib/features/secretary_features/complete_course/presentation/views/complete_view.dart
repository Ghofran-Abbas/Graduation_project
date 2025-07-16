import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/all_courses_cubit/all_courses_cubit.dart';
import 'widgets/complete_view_body.dart';

class CompleteView extends StatelessWidget {
  const CompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return AllCoursesCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchAllCourses(page: 1);
          },
        ),
      ],
      child: const CompleteViewBody(),
    );
  }
}
