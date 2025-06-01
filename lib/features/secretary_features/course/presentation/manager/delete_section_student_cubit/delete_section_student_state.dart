import 'package:equatable/equatable.dart';

import '../../../data/models/delete_section_student_model.dart';

abstract class DeleteSectionStudentState extends Equatable{
  const DeleteSectionStudentState();

  @override
  List<Object> get props => [];
}
class DeleteSectionStudentInitial extends DeleteSectionStudentState {}
class DeleteSectionStudentLoading extends DeleteSectionStudentState {}
class DeleteSectionStudentFailure extends DeleteSectionStudentState {
  final String errorMessage;

  const DeleteSectionStudentFailure(this.errorMessage);
}
class DeleteSectionStudentSuccess extends DeleteSectionStudentState {
  final DeleteSectionStudentModel deleteResult;

  const DeleteSectionStudentSuccess(this.deleteResult);
}