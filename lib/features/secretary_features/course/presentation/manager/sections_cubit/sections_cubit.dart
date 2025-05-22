import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/sections_model.dart';
import '../../../data/repos/course_repo.dart';
import 'sections_state.dart';

class SectionsCubit extends Cubit<SectionsState>{

  static SectionsCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  SectionsCubit(this.courseRepo) : super(SectionsInitial());

  Future<void> fetchSections({
    required int id,
  }) async {
    emit(SectionsLoading());
    var result = await courseRepo.fetchSections(
      id: id,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(SectionsFailure(failure.errorMessage));
    }, (sections) {
      emit(SectionsSuccess(sections));
    });
  }
}

class SelectSectionCubit extends Cubit<SelectSectionState> {
  static SelectSectionCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  SelectSectionCubit(this.courseRepo) : super(SelectSectionInitial());

  void selectSection({required Section section}) {
    emit(SelectSectionSuccess(section));
  }
}