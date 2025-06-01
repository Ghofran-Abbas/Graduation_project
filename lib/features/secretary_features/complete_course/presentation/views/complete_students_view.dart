import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../course/data/repos/course_repo_impl.dart';
import '../../../course/presentation/manager/confirmed_students_section_cubit/confirmed_students_section_cubit.dart';
import '../../../course/presentation/manager/reservation_students_section_cubit/reservation_students_section_cubit.dart';
import 'widgets/complete_students_view_body.dart';

class CompleteStudentsView extends StatelessWidget {
  const CompleteStudentsView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      ],
      child: CompleteStudentsViewBody(),
    );
  }
}
