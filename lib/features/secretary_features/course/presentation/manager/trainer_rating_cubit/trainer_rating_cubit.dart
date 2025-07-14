import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'trainer_rating_state.dart';

class TrainerRatingCubit extends Cubit<TrainerRatingState>{

  static TrainerRatingCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  TrainerRatingCubit(this.courseRepo) : super(TrainerRatingInitial());

  Future<void> fetchTrainerRating({required int trainerId, required int sectionId}) async {
    emit(TrainerRatingLoading());
    var result = await courseRepo.fetchTrainerRating(
      trainerId: trainerId,
      sectionId: sectionId,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(TrainerRatingFailure(failure.errorMessage));
    }, (trainerRating) {
      emit(TrainerRatingSuccess(trainerRating));
    });
  }
}