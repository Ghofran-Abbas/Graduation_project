import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'delete_section_trainer_state.dart';

class DeleteSectionTrainerCubit extends Cubit<DeleteSectionTrainerState>{
  static DeleteSectionTrainerState get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  DeleteSectionTrainerCubit(this.courseRepo) : super(DeleteSectionTrainerInitial());

  Future<void> fetchDeleteSectionTrainer({
    required int sectionId,
    required int trainerId,
  }) async {
    emit(DeleteSectionTrainerLoading());
    var result = await courseRepo.fetchDeleteSectionTrainer(
      sectionId: sectionId,
      trainerId: trainerId,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteSectionTrainerFailure(failure.errorMessage));
    }, (deleteResult) {
      emit(DeleteSectionTrainerSuccess(deleteResult));
    });
  }
}