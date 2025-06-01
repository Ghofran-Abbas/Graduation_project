import 'package:equatable/equatable.dart';

import '../../../data/models/confirm_reservation_student_model.dart';

abstract class ConfirmReservationStudentState extends Equatable{
  const ConfirmReservationStudentState();

  @override
  List<Object> get props => [];
}
class ConfirmReservationStudentInitial extends ConfirmReservationStudentState {}
class ConfirmReservationStudentLoading extends ConfirmReservationStudentState {}
class ConfirmReservationStudentFailure extends ConfirmReservationStudentState {
  final String errorMessage;

  const ConfirmReservationStudentFailure(this.errorMessage);
}
class ConfirmReservationStudentSuccess extends ConfirmReservationStudentState {
  final ConfirmReservationStudentModel confirmResult;

  const ConfirmReservationStudentSuccess(this.confirmResult);
}