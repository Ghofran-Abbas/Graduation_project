import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_trainer_state.dart';

class UpdateTrainerCubit extends Cubit<UpdateTrainerState>{
  static UpdateTrainerState get(context) => BlocProvider.of(context);

  UpdateTrainerCubit(this.trainerRepo,) : super(UpdateTrainerInitial());

  final TrainerRepo trainerRepo;

  Future<void> fetchUpdateTrainer({
    required int id,
    String? name,
    String? phone,
    String? birthday,
    String? gender,
    Uint8List? photo,
  }) async {
    emit(UpdateTrainerLoading());
    var result = await trainerRepo.fetchUpdateTrainer(
      id: id,
      name: name,
      phone: phone,
      birthday: birthday,
      gender: gender,
      photo: photo,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(UpdateTrainerFailure(failure.errorMessage));
    }, (updateResult) {
      emit(UpdateTrainerSuccess(updateResult));
    });
  }
}