import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'confirmed_students_section_state.dart';

class ConfirmedStudentsSectionCubit extends Cubit<ConfirmedStudentsSectionState>{
  static ConfirmedStudentsSectionCubit get(context) => BlocProvider.of(context);

  ConfirmedStudentsSectionCubit(this.courseRepo) : super(ConfirmedStudentsSectionInitial());

  final CourseRepo courseRepo;

  Future<void> fetchConfirmedStudentsSection({required int id, required int page}) async {
    emit(ConfirmedStudentsSectionLoading());
    var result = await courseRepo.fetchConfirmedStudentsSection(id: id, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ConfirmedStudentsSectionFailure(failure.errorMessage));
    }, (confirmedStudents) {
      emit(ConfirmedStudentsSectionSuccess(confirmedStudents));
    });
  }
}
