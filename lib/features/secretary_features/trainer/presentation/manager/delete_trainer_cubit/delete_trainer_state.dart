import 'package:equatable/equatable.dart';

import '../../../data/models/delete_trainer_model.dart';

abstract class DeleteTrainerState extends Equatable{
  const DeleteTrainerState();

  @override
  List<Object> get props => [];
}

class DeleteTrainerInitial extends DeleteTrainerState{}
class DeleteTrainerLoading extends DeleteTrainerState{}
class DeleteTrainerFailure extends DeleteTrainerState{
  final String errorMessage;

  const DeleteTrainerFailure(this.errorMessage);
}
class DeleteTrainerSuccess extends DeleteTrainerState{
  final DeleteTrainerModel deleteResult;

  const DeleteTrainerSuccess(this.deleteResult);
}