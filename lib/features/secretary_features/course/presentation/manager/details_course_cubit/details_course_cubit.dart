import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/course/data/repos/course_repo.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/details_course_cubit/details_course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCourseCubit extends Cubit<DetailsCourseState>{
  static DetailsCourseState get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  DetailsCourseCubit(this.courseRepo) : super(DetailsCourseInitial());

  Future<void> fetchDetailsCourse({required int id}) async {
    emit(DetailsCourseLoading());
    var result = await courseRepo.fetchDetailsCourse(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DetailsCourseFailure(failure.errorMessage));
    }, (course) {
      emit(DetailsCourseSuccess(course));
    });
  }
}