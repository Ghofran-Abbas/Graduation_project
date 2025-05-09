import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'details_trainer_state.dart';

class DetailsTrainerCubit extends Cubit<DetailsTrainerState> {

  static DetailsTrainerCubit get(context) => BlocProvider.of(context);

  DetailsTrainerCubit(this.trainerRepo,) : super(DetailsTrainerInitial());

  final TrainerRepo trainerRepo;

  Future<void> fetchDetailsTrainer({
    required int id,
  }) async {
    emit(DetailsTrainerLoading());
    var result = await trainerRepo.fetchDetailsTrainer(
      id: id,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DetailsTrainerFailure(failure.errorMessage));
    }, (detailsTrainer) {
      emit(DetailsTrainerSuccess(detailsTrainer));
    },
    );
  }
}