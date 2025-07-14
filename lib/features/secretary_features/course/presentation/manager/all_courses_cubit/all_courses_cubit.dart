import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'all_courses_state.dart';

class AllCoursesCubit extends Cubit<AllCoursesState>{

  static AllCoursesCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  AllCoursesCubit(this.courseRepo) : super(AllCoursesInitial());

  Future<void> fetchAllCourses({required int page}) async {
    emit(AllCoursesLoading());
    var result = await courseRepo.fetchAllCourses(
      page: page,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(AllCoursesFailure(failure.errorMessage));
    }, (allCourses) {
      emit(AllCoursesSuccess(allCourses));
    });
  }
}