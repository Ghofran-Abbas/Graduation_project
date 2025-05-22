import 'package:equatable/equatable.dart';

import '../../../data/models/add_section_student_model.dart';

abstract class AddSectionStudentState extends Equatable{
  const AddSectionStudentState();

  @override
  List<Object?> get props => [];
}

class AddSectionStudentInitial extends AddSectionStudentState{}
class AddSectionStudentLoading extends AddSectionStudentState{}
class AddSectionStudentFailure extends AddSectionStudentState{
  final String errorMessage;

  const AddSectionStudentFailure(this.errorMessage);
}
class AddSectionStudentSuccess extends AddSectionStudentState{
  final AddSectionStudentModel addResult;

  const AddSectionStudentSuccess(this.addResult);
}