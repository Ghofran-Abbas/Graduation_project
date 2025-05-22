import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'search_course_state.dart';

class SearchCourseCubit extends Cubit<SearchCourseState>{
  static SearchCourseState get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  SearchCourseCubit(this.courseRepo) : super(SearchCourseInitial());

  Future<void> fetchSearchCourse({required String querySearch, required int page}) async {
    emit(SearchCourseLoading());
    var result = await courseRepo.fetchSearchCourse(querySearch: querySearch, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(SearchCourseFailure(failure.errorMessage));
    }, (course) {
      emit(SearchCourseSuccess(course));
    });
  }
}