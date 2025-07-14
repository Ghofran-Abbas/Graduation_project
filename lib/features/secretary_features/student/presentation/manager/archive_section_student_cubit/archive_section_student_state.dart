import 'package:equatable/equatable.dart';

import '../../../data/models/archive_section_student_model.dart';

abstract class ArchiveStudentState extends Equatable {
  const ArchiveStudentState();

  @override
  List<Object> get props => [];
}

class ArchiveStudentInitial extends ArchiveStudentState {}
class ArchiveStudentLoading extends ArchiveStudentState {}
class ArchiveStudentFailure extends ArchiveStudentState {
  final String errorMessage;

  const ArchiveStudentFailure(this.errorMessage);
}
class ArchiveStudentSuccess extends ArchiveStudentState {
  final ArchiveSectionStudentModel showResult;

  const ArchiveStudentSuccess(this.showResult);
}