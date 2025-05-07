import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/create_trainer_cubit/create_trainer_state.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/trainers_cubit/trainers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainersCubit extends Cubit<TrainersState> {

  static TrainersCubit get(context) => BlocProvider.of(context);

  TrainersCubit(this.trainerRepo) : super (TrainersInitial());

  final TrainerRepo trainerRepo;

  Future<void> fetchTrainers() async {
    emit(TrainersLoading());
    var result = await trainerRepo.fetchTrainers();

    result.fold((failure) {
      log(failure.errorMessage);
      emit(TrainersFailure(failure.errorMessage));
    }, (trainers) {
      emit(TrainersSuccess(trainers));
    },
    );
  }
}