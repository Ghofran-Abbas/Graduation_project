import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_trainer_state.dart';

class SearchTrainerCubit extends Cubit<SearchTrainerState>{
  static SearchTrainerState get(context) => BlocProvider.of(context);

  final TrainerRepo trainerRepo;

  SearchTrainerCubit(this.trainerRepo) : super(SearchTrainerInitial());

  Future<void> fetchSearchTrainer({required String querySearch, required int page}) async {
    emit(SearchTrainerLoading());
    var result = await trainerRepo.fetchSearchTrainer(querySearch: querySearch, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(SearchTrainerFailure(failure.errorMessage));
    }, (trainer) {
      emit(SearchTrainerSuccess(trainer));
    });
  }
}