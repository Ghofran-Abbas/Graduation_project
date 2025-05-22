import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'delete_course_state.dart';

class DeleteCourseCubit extends Cubit<DeleteCourseState>{

  static DeleteCourseCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  DeleteCourseCubit(this.courseRepo) : super(DeleteCourseInitial());

  Future<void> fetchDeleteCourse({required int id}) async {
    emit(DeleteCourseLoading());
    var result = await courseRepo.fetchDeleteCourse(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteCourseFailure(failure.errorMessage));
    }, (deleteResult) {
      emit(DeleteCourseSuccess(deleteResult));
    });
  }
}