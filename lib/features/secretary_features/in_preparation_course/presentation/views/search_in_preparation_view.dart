import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/search_course_cubit/search_course_cubit.dart';
import 'widgets/search_in_preparation_view_body.dart';

class SearchInPreparationView extends StatelessWidget {
  const SearchInPreparationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchCourseCubit(
          getIt.get<CourseRepoImpl>(),
        );
      },
      child: SearchInPreparationViewBody(),
    );
  }
}
