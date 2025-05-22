import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'add_section_trainer_state.dart';

class AddSectionTrainerCubit extends Cubit<AddSectionTrainerState>{
  static AddSectionTrainerState get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  AddSectionTrainerCubit(this.courseRepo) : super(AddSectionTrainerInitial());

  Future<void> fetchAddSectionTrainer({
    required int sectionId,
    required int trainerId,
  }) async {
    emit(AddSectionTrainerLoading());
    var result = await courseRepo.fetchAddSectionTrainer(
      sectionId: sectionId,
      trainerId: trainerId,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(AddSectionTrainerFailure(failure.errorMessage));
    }, (addResult) {
      emit(AddSectionTrainerSuccess(addResult));
    });
  }
}