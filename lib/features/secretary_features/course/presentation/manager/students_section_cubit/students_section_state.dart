import 'package:equatable/equatable.dart';

import '../../../data/models/students_section_model.dart';

abstract class StudentsSectionState extends Equatable{
  const StudentsSectionState();

  @override
  List<Object> get props => [];
}
class StudentsSectionInitial extends StudentsSectionState {}
class StudentsSectionLoading extends StudentsSectionState {}
class StudentsSectionFailure extends StudentsSectionState {
  final String errorMessage;

  const StudentsSectionFailure(this.errorMessage);
}
class StudentsSectionSuccess extends StudentsSectionState {
  final StudentsSectionModel students;

  const StudentsSectionSuccess(this.students);
}