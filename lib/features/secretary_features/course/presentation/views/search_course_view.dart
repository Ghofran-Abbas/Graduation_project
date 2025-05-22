import 'package:alhadara_dashboard/features/secretary_features/course/data/repos/course_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/search_course_cubit/search_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import 'widgets/search_course_view_body.dart';

class SearchCourseView extends StatelessWidget {
  const SearchCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchCourseCubit(
          getIt.get<CourseRepoImpl>(),
        );
      },
      child: SearchCourseViewBody(),
    );
  }
}
