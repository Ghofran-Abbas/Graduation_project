import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'add_section_student_state.dart';

class AddSectionStudentCubit extends Cubit<AddSectionStudentState>{
  static AddSectionStudentState get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  AddSectionStudentCubit(this.courseRepo) : super(AddSectionStudentInitial());

  Future<void> fetchAddSectionStudent({
    required int sectionId,
    required int studentId,
  }) async {
    emit(AddSectionStudentLoading());
    var result = await courseRepo.fetchAddSectionStudent(
      sectionId: sectionId,
      studentId: studentId,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(AddSectionStudentFailure(failure.errorMessage));
    }, (addResult) {
      emit(AddSectionStudentSuccess(addResult));
    });
  }
}