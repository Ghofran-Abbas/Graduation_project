import 'package:equatable/equatable.dart';

import '../../../data/models/details_trainer_model.dart';

abstract class DetailsTrainerState extends Equatable {
  const DetailsTrainerState();

  @override
  List<Object> get props => [];
}

class DetailsTrainerInitial extends DetailsTrainerState {}
class DetailsTrainerLoading extends DetailsTrainerState {}
class DetailsTrainerFailure extends DetailsTrainerState {
  final String errorMessage;

  const DetailsTrainerFailure(this.errorMessage);
}
class DetailsTrainerSuccess extends DetailsTrainerState {
  final DetailsTrainerModel showResult;

  const DetailsTrainerSuccess(this.showResult);
}