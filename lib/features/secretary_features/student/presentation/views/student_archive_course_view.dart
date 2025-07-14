import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/data/repos/course_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../data/repos/student_repo_impl.dart';
import '../manager/archive_section_student_cubit/archive_section_student_cubit.dart';
import 'widgets/student_archive_course_view_body.dart';

class StudentArchiveCourseView extends StatelessWidget {
  const StudentArchiveCourseView({super.key, required this.studentId});

  final int studentId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return StudentsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return TrainersSectionCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return ArchiveStudentCubit(
              getIt.get<StudentRepoImpl>(),
            )..fetchArchiveStudent(id: studentId, page: 1);
          },
        ),
      ],
      child: StudentArchiveCourseViewBody(studentId: studentId,),
    );
  }
}
