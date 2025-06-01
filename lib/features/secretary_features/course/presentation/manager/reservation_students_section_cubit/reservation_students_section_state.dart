import 'package:equatable/equatable.dart';

import '../../../data/models/reservation_students_section_model.dart';

abstract class ReservationStudentsSectionState extends Equatable{
  const ReservationStudentsSectionState();

  @override
  List<Object> get props => [];
}
class ReservationStudentsSectionInitial extends ReservationStudentsSectionState {}
class ReservationStudentsSectionLoading extends ReservationStudentsSectionState {}
class ReservationStudentsSectionFailure extends ReservationStudentsSectionState {
  final String errorMessage;

  const ReservationStudentsSectionFailure(this.errorMessage);
}
class ReservationStudentsSectionSuccess extends ReservationStudentsSectionState {
  final ReservationStudentsSectionModel reservationStudents;

  const ReservationStudentsSectionSuccess(this.reservationStudents);
}