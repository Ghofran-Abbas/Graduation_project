import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/create_trainer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

abstract class CreateTrainerState extends Equatable {
  const CreateTrainerState();

  @override
  List<Object> get props => [];
}

class CreateTrainerInitial extends CreateTrainerState {}
class CreateTrainerLoading extends CreateTrainerState {}
class CreateTrainerFailure extends CreateTrainerState {
  final String errorMessage;

  const CreateTrainerFailure(this.errorMessage);
}
class CreateTrainerSuccess extends CreateTrainerState {
  final CreateTrainerModel createResult;

  const CreateTrainerSuccess(this.createResult);
}

class ImagePickedSuccess extends CreateTrainerState {
  final FilePickerResult image;

  const ImagePickedSuccess(this.image);
}