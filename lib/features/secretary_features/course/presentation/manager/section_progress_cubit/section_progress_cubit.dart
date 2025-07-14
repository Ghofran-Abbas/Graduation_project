import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'section_progress_state.dart';

class SectionProgressCubit extends Cubit<SectionProgressState>{

  static SectionProgressCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  SectionProgressCubit(this.courseRepo) : super(SectionProgressInitial());

  Future<void> fetchSectionProgress({required int sectionId}) async {
    emit(SectionProgressLoading());
    var result = await courseRepo.fetchSectionProgress(
      sectionId: sectionId
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(SectionProgressFailure(failure.errorMessage));
    }, (sectionProgress) {
      emit(SectionProgressSuccess(sectionProgress));
    });
  }
}