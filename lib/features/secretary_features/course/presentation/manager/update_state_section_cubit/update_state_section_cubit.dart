import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'update_state_section_state.dart';

class UpdateStateSectionCubit extends Cubit<UpdateStateSectionState>{
  static UpdateStateSectionCubit get(context) => BlocProvider.of(context);

  UpdateStateSectionCubit(this.courseRepo) : super(UpdateStateSectionInitial());

  final CourseRepo courseRepo;

  Future<void> fetchUpdateStateSection({
    required int courseId,
    String? state,
  }) async {
    emit(UpdateStateSectionLoading());
    var result = await courseRepo.fetchUpdateStateSection(
      courseId: courseId,
      state: state,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(UpdateStateSectionFailure(failure.errorMessage));
    }, (updateResult) {
      emit(UpdateStateSectionSuccess(updateResult));
    });
  }
}