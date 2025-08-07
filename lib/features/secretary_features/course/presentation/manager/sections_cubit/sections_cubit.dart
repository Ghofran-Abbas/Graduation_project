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
    required int page,
  }) async {
    emit(SectionsLoading());
    var result = await courseRepo.fetchSections(
      id: id,
      page: page
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(SectionsFailure(failure.errorMessage));
    }, (sections) {
      final current = sections.currentPage;
      final last    = sections.lastPage;
      emit(SectionsSuccess(createResult: sections, currentPage: current, lastPage: last,));
    });
  }
}

class SelectSectionCubit extends Cubit<SelectSectionState> {
  static SelectSectionCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  SelectSectionCubit(this.courseRepo) : super(SelectSectionInitial());

  void selectSection({required DatumSection section}) {
    emit(SelectSectionSuccess(section));
  }

  void clearSelection() {
    emit(SelectSectionInitial());
  }
}