import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'students_section_state.dart';

class StudentsSectionCubit extends Cubit<StudentsSectionState>{
  static StudentsSectionCubit get(context) => BlocProvider.of(context);

  StudentsSectionCubit(this.courseRepo) : super(StudentsSectionInitial());

  final CourseRepo courseRepo;

  Future<void> fetchStudentsSection({required int id, required int page}) async {
    emit(StudentsSectionLoading());
    var result = await courseRepo.fetchStudentsSection(id: id, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(StudentsSectionFailure(failure.errorMessage));
    }, (students) {
      emit(StudentsSectionSuccess(students));
    });
  }
}