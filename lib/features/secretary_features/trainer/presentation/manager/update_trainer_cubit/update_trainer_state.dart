import 'package:equatable/equatable.dart';

import '../../../data/models/update_trainer_model.dart';

abstract class UpdateTrainerState extends Equatable{
  const UpdateTrainerState();

  @override
  List<Object> get props => [];
}

class UpdateTrainerInitial extends UpdateTrainerState{}
class UpdateTrainerLoading extends UpdateTrainerState{}
class UpdateTrainerFailure extends UpdateTrainerState{
  final String errorMessage;

  const UpdateTrainerFailure(this.errorMessage);
}
class UpdateTrainerSuccess extends UpdateTrainerState{
  final UpdateTrainerModel updateResult;

  const UpdateTrainerSuccess(this.updateResult);
}