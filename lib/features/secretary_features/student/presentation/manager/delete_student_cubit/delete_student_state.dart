import 'package:equatable/equatable.dart';

import '../../../data/models/delete_student_model.dart';

abstract class DeleteStudentState extends Equatable{
  const DeleteStudentState();

  @override
  List<Object> get props => [];
}

class DeleteStudentInitial extends DeleteStudentState{}
class DeleteStudentLoading extends DeleteStudentState{}
class DeleteStudentFailure extends DeleteStudentState{
  final String errorMessage;

  const DeleteStudentFailure(this.errorMessage);
}
class DeleteStudentSuccess extends DeleteStudentState{
  final DeleteStudentModel deleteResult;

  const DeleteStudentSuccess(this.deleteResult);
}