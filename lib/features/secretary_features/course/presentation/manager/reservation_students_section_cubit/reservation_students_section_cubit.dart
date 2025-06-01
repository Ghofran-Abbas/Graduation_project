import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'reservation_students_section_state.dart';

class ReservationStudentsSectionCubit extends Cubit<ReservationStudentsSectionState>{
  static ReservationStudentsSectionCubit get(context) => BlocProvider.of(context);

  ReservationStudentsSectionCubit(this.courseRepo) : super(ReservationStudentsSectionInitial());

  final CourseRepo courseRepo;

  Future<void> fetchReservationStudentsSection({required int id, required int page}) async {
    emit(ReservationStudentsSectionLoading());
    var result = await courseRepo.fetchReservationStudentsSection(id: id, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ReservationStudentsSectionFailure(failure.errorMessage));
    }, (reservationStudents) {
      emit(ReservationStudentsSectionSuccess(reservationStudents));
    });
  }
}