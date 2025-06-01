import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'confirm_reservation_student_state.dart';

class ConfirmReservationStudentCubit extends Cubit<ConfirmReservationStudentState>{
  static ConfirmReservationStudentCubit get(context) => BlocProvider.of(context);

  ConfirmReservationStudentCubit(this.courseRepo) : super(ConfirmReservationStudentInitial());

  final CourseRepo courseRepo;

  Future<void> fetchConfirmReservationStudent({required int reservationId,}) async {
    emit(ConfirmReservationStudentLoading());
    var result = await courseRepo.fetchConfirmReservationStudent(reservationId: reservationId,);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ConfirmReservationStudentFailure(failure.errorMessage));
    }, (confirmResult) {
      emit(ConfirmReservationStudentSuccess(confirmResult));
    });
  }
}