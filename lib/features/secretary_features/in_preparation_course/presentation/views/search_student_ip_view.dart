import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/add_section_student_cubit/add_section_student_cubit.dart';
import '../../../student/data/repos/student_repo_impl.dart';
import '../../../student/presentation/manager/search_student_cubit/search_student_cubit.dart';
import 'widgets/search_student_ip_view_body.dart';

class SearchStudentIpView extends StatelessWidget {
  const SearchStudentIpView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return SearchStudentCubit(
              getIt.get<StudentRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return AddSectionStudentCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
      ],
      child: SearchStudentIpViewBody(sectionId: sectionId,),
    );
  }
}
