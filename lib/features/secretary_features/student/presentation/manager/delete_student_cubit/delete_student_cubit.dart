import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/student_repo.dart';
import 'delete_student_state.dart';

class DeleteStudentCubit extends Cubit<DeleteStudentState>{
  static DeleteStudentState get(context) => BlocProvider.of(context);

  DeleteStudentCubit(this.studentRepo,) : super(DeleteStudentInitial());

  final StudentRepo studentRepo;

  Future<void> fetchDeleteStudent({
    required int id,
  }) async {
    emit(DeleteStudentLoading());
    var result = await studentRepo.fetchDeleteStudent(
      id: id,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteStudentFailure(failure.errorMessage));
    }, (updateResult) {
      emit(DeleteStudentSuccess(updateResult));
    });
  }
}