import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/repos/student_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/details_student_cubit/details_student_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/archive_section_student_cubit/archive_section_student_cubit.dart';
import 'widgets/student_details_view_body.dart';

class StudentDetailsView extends StatefulWidget {
  const StudentDetailsView({super.key, required this.id});

  final int id;

  @override
  State<StudentDetailsView> createState() => _StudentDetailsViewState();
}

class _StudentDetailsViewState extends State<StudentDetailsView> {
  late final DetailsStudentCubit _cubit;
  late final ArchiveStudentCubit _archiveCubit;
  late int _currentId;

  @override
  void initState() {
    super.initState();
    _cubit = DetailsStudentCubit(getIt.get<StudentRepoImpl>());
    _archiveCubit = ArchiveStudentCubit(getIt.get<StudentRepoImpl>());
    _currentId = widget.id;
    _cubit.fetchDetailsStudent(id: _currentId);
    _archiveCubit.fetchArchiveStudent(id: _currentId, page: 1);
  }

  @override
  void didUpdateWidget(covariant StudentDetailsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _currentId = widget.id;
      _cubit.fetchDetailsStudent(id: _currentId);
      _archiveCubit.fetchArchiveStudent(id: _currentId, page: 1);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    _archiveCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _cubit,

        ),
        BlocProvider.value(
          value: _archiveCubit,
        ),
      ],
      child: StudentDetailsViewBody(studentId: widget.id,),
    );
  }
}

