import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/course/data/repos/course_repo.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/courses_cubit/courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesCubit extends Cubit<CoursesState>{

  static CoursesCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  CoursesCubit(this.courseRepo) : super(CoursesInitial());

  Future<void> fetchCourses({required int departmentId, required int page}) async {
    emit(CoursesLoading());
    var result = await courseRepo.fetchCourses(
      departmentId: departmentId,
      page: page,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CoursesFailure(failure.errorMessage));
    }, (courses) {
      emit(CoursesSuccess(courses));
    });
  }
}