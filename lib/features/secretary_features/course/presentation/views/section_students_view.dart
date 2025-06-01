import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/course_repo_impl.dart';
import '../manager/confirm_reservation_student_cubit/confirm_reservation_student_cubit.dart';
import '../manager/confirmed_students_section_cubit/confirmed_students_section_cubit.dart';
import '../manager/delete_section_student_cubit/delete_section_student_cubit.dart';
import '../manager/reservation_students_section_cubit/reservation_students_section_cubit.dart';
import '../manager/students_section_cubit/students_section_cubit.dart';
import 'widgets/section_students_view_body.dart';

class SectionStudentsView extends StatelessWidget {
  const SectionStudentsView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return StudentsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchStudentsSection(id: sectionId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return ConfirmedStudentsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchConfirmedStudentsSection(id: sectionId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return ReservationStudentsSectionCubit(
              getIt.get<CourseRepoImpl>(),
            )..fetchReservationStudentsSection(id: sectionId, page: 1);
          },
        ),
        BlocProvider(
          create: (context) {
            return DeleteSectionStudentCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return ConfirmReservationStudentCubit(
              getIt.get<CourseRepoImpl>(),
            );
          },
        ),
      ],
      child: SectionStudentsViewBody(sectionId: sectionId,),
    );
  }
}
