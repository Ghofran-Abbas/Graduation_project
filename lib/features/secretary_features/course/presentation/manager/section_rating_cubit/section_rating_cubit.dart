import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'section_rating_state.dart';

class SectionRatingCubit extends Cubit<SectionRatingState>{

  static SectionRatingCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  SectionRatingCubit(this.courseRepo) : super(SectionRatingInitial());

  Future<void> fetchSectionRating({required int sectionId}) async {
    emit(SectionRatingLoading());
    var result = await courseRepo.fetchSectionRating(
      sectionId: sectionId,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(SectionRatingFailure(failure.errorMessage));
    }, (sectionRating) {
      emit(SectionRatingSuccess(sectionRating));
    });
  }
}
