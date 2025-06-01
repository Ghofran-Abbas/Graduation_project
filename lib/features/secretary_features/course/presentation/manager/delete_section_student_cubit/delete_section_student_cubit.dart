import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'delete_section_student_state.dart';

class DeleteSectionStudentCubit extends Cubit<DeleteSectionStudentState>{
  static DeleteSectionStudentCubit get(context) => BlocProvider.of(context);

  DeleteSectionStudentCubit(this.courseRepo) : super(DeleteSectionStudentInitial());

  final CourseRepo courseRepo;

  Future<void> fetchDeleteSectionStudent({required int sectionId, required int studentId,}) async {
    emit(DeleteSectionStudentLoading());
    var result = await courseRepo.fetchDeleteSectionStudent(
      sectionId: sectionId,
      studentId: studentId,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteSectionStudentFailure(failure.errorMessage));
    }, (deleteResult) {
      emit(DeleteSectionStudentSuccess(deleteResult));
    });
  }
}