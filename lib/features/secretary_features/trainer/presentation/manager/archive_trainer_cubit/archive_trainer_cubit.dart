import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/trainer_repo.dart';
import 'archive_trainer_state.dart';

class ArchiveTrainerCubit extends Cubit<ArchiveTrainerState> {

  static ArchiveTrainerCubit get(context) => BlocProvider.of(context);

  ArchiveTrainerCubit(this.trainerRepo,) : super(ArchiveTrainerInitial());

  final TrainerRepo trainerRepo;

  Future<void> fetchArchiveTrainer({required int id, required int page}) async {
    emit(ArchiveTrainerLoading());
    var result = await trainerRepo.fetchArchiveTrainer(id: id, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ArchiveTrainerFailure(failure.errorMessage));
    }, (archiveTrainer) {
      emit(ArchiveTrainerSuccess(archiveTrainer));
    },
    );
  }
}