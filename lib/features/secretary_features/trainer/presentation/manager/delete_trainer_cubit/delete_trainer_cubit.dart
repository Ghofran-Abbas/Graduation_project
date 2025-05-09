import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_trainer_state.dart';

class DeleteTrainerCubit extends Cubit<DeleteTrainerState>{
  static DeleteTrainerState get(context) => BlocProvider.of(context);

  DeleteTrainerCubit(this.trainerRepo,) : super(DeleteTrainerInitial());

  final TrainerRepo trainerRepo;

  Future<void> fetchDeleteTrainer({
    required int id,
  }) async {
    emit(DeleteTrainerLoading());
    var result = await trainerRepo.fetchDeleteTrainer(
      id: id,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteTrainerFailure(failure.errorMessage));
    }, (updateResult) {
      emit(DeleteTrainerSuccess(updateResult));
    });
  }
}