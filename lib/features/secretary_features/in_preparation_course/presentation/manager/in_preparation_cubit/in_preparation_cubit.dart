import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../course/data/repos/course_repo.dart';
import '../../../data/models/in_preparation_model.dart';
import 'in_preparation_state.dart';

class InPreparationCubit extends Cubit<InPreparationState>{

  static InPreparationCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  InPreparationCubit(this.courseRepo) : super(InPreparationInitial());

  Future<void> fetchInPreparation({
    required int courseId,
    required int page,
  }) async {
    emit(InPreparationLoading());
    var result = await courseRepo.fetchPendingSection(
      courseId: courseId,
      page: page,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(InPreparationFailure(failure.errorMessage));
    }, (inPreparation) {
      emit(InPreparationSuccess(inPreparation));
    });
  }
}

class SelectInPreparationCubit extends Cubit<SelectInPreparationState> {
  static SelectInPreparationCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  SelectInPreparationCubit(this.courseRepo) : super(SelectSectionInitial());

  void selectSection({required DatumInPreparation section}) {
    emit(SelectInPreparationSuccess(section));
  }

  void clearSelection() {
    emit(SelectSectionInitial());
  }
}