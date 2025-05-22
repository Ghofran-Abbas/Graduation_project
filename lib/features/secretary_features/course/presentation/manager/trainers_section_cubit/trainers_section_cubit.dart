import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';

class TrainersSectionCubit extends Cubit<TrainersSectionState>{
  static TrainersSectionCubit get(context) => BlocProvider.of(context);

  TrainersSectionCubit(this.courseRepo) : super(TrainersSectionInitial());

  final CourseRepo courseRepo;

  Future<void> fetchTrainersSection({required int id, required int page}) async {
    emit(TrainersSectionLoading());
    var result = await courseRepo.fetchTrainersSection(id: id, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(TrainersSectionFailure(failure.errorMessage));
    }, (trainers) {
      emit(TrainersSectionSuccess(trainers));
    });
  }
}