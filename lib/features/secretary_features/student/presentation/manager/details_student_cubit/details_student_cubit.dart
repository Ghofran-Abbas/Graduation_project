import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/student_repo.dart';
import 'details_student_state.dart';

class DetailsStudentCubit extends Cubit<DetailsStudentState> {

  static DetailsStudentCubit get(context) => BlocProvider.of(context);

  DetailsStudentCubit(this.studentRepo,) : super(DetailsStudentInitial());

  final StudentRepo studentRepo;

  Future<void> fetchDetailsStudent({
    required int id,
}) async {
    emit(DetailsStudentLoading());
    var result = await studentRepo.fetchDetailsStudent(
      id: id,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DetailsStudentFailure(failure.errorMessage));
    }, (detailsStudent) {
      emit(DetailsStudentSuccess(detailsStudent));
    },
    );
  }
}