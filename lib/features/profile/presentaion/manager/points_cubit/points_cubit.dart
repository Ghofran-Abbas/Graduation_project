import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/profile_repo.dart';
import 'points_state.dart';

class PointsCubit extends Cubit<PointsState>{

  static PointsCubit get(context) => BlocProvider.of(context);

  PointsCubit(this.profileRepo) : super(PointsInitial());

  final ProfileRepo profileRepo;

  Future<void> fetchPoints() async {
    emit(PointsLoading());
    var result = await profileRepo.fetchPoints();

    result.fold((failure) {
      log(failure.errorMessage);
      emit(PointsFailure(failure.errorMessage));
    }, (points) {
      emit(PointsSuccess(points));
    });
  }
}