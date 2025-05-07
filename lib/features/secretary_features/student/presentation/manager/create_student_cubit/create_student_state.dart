import 'package:alhadara_dashboard/features/secretary_features/student/data/models/create_student_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class CreateStudentState extends Equatable {
  const CreateStudentState();

  @override
  List<Object> get props => [];
}

class CreateStudentInitial extends CreateStudentState {}
class CreateStudentLoading extends CreateStudentState {}
class CreateStudentFailure extends CreateStudentState {
  final String errorMessage;

  const CreateStudentFailure(this.errorMessage);
}
class CreateStudentSuccess extends CreateStudentState {
  final CreateStudentModel createResult;

  const CreateStudentSuccess(this.createResult);
}

class ImagePickedSuccess extends CreateStudentState {
  final FilePickerResult image;

  const ImagePickedSuccess(this.image);
}