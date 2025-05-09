import 'package:equatable/equatable.dart';

import '../../../data/models/details_student_model.dart';

abstract class DetailsStudentState extends Equatable {
  const DetailsStudentState();

  @override
  List<Object> get props => [];
}

class DetailsStudentInitial extends DetailsStudentState {}
class DetailsStudentLoading extends DetailsStudentState {}
class DetailsStudentFailure extends DetailsStudentState {
  final String errorMessage;

  const DetailsStudentFailure(this.errorMessage);
}
class DetailsStudentSuccess extends DetailsStudentState {
  final DetailsStudentModel showResult;

  const DetailsStudentSuccess(this.showResult);
}