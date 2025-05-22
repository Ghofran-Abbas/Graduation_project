import 'package:equatable/equatable.dart';

import '../../../data/models/delete_section_trainer_model.dart';

abstract class DeleteSectionTrainerState extends Equatable{
  const DeleteSectionTrainerState();

  @override
  List<Object?> get props => [];
}

class DeleteSectionTrainerInitial extends DeleteSectionTrainerState{}
class DeleteSectionTrainerLoading extends DeleteSectionTrainerState{}
class DeleteSectionTrainerFailure extends DeleteSectionTrainerState{
  final String errorMessage;

  const DeleteSectionTrainerFailure(this.errorMessage);
}
class DeleteSectionTrainerSuccess extends DeleteSectionTrainerState{
  final DeleteSectionTrainerModel deleteResult;

  const DeleteSectionTrainerSuccess(this.deleteResult);
}