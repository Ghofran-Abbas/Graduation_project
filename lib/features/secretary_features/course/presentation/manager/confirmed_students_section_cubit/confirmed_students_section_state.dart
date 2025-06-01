import 'package:equatable/equatable.dart';

import '../../../data/models/confirmed_students_section_model.dart';

abstract class ConfirmedStudentsSectionState extends Equatable{
  const ConfirmedStudentsSectionState();

  @override
  List<Object> get props => [];
}
class ConfirmedStudentsSectionInitial extends ConfirmedStudentsSectionState {}
class ConfirmedStudentsSectionLoading extends ConfirmedStudentsSectionState {}
class ConfirmedStudentsSectionFailure extends ConfirmedStudentsSectionState {
  final String errorMessage;

  const ConfirmedStudentsSectionFailure(this.errorMessage);
}
class ConfirmedStudentsSectionSuccess extends ConfirmedStudentsSectionState {
  final ConfirmedStudentsSectionModel confirmedStudents;

  const ConfirmedStudentsSectionSuccess(this.confirmedStudents);
}
