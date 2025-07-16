import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../course/data/repos/course_repo.dart';
import '../../../data/models/complete_model.dart';
import 'complete_state.dart';

class CompleteCubit extends Cubit<CompleteState>{

  static CompleteCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  CompleteCubit(this.courseRepo) : super(CompleteInitial());

  Future<void> fetchComplete({
    required int courseId,
    required int page,
  }) async {
    emit(CompleteLoading());
    var result = await courseRepo.fetchFinishedSection(
      courseId: courseId,
      page: page,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CompleteFailure(failure.errorMessage));
    }, (complete) {
      emit(CompleteSuccess(complete));
    });
  }
}

class SelectCompleteCubit extends Cubit<SelectCompleteState> {
  static SelectCompleteCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  SelectCompleteCubit(this.courseRepo) : super(SelectSectionInitial());

  void selectSection({required DatumComplete section}) {
    emit(SelectCompleteSuccess(section));
  }

  void clearSelection() {
    emit(SelectSectionInitial());
  }
}