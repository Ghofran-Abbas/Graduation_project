import 'package:alhadara_dashboard/features/secretary_features/student/data/models/create_student_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/models/students_model.dart';

abstract class StudentsState extends Equatable {
  const StudentsState();

  @override
  List<Object> get props => [];
}

class StudentsInitial extends StudentsState {}
class StudentsLoading extends StudentsState {}
class StudentsFailure extends StudentsState {
  final String errorMessage;

  const StudentsFailure(this.errorMessage);
}
class StudentsSuccess extends StudentsState {
  final StudentsModel showResult;

  const StudentsSuccess(this.showResult);
}