import 'package:equatable/equatable.dart';

import '../../../data/models/add_section_trainer_model.dart';

abstract class AddSectionTrainerState extends Equatable{
  const AddSectionTrainerState();

  @override
  List<Object?> get props => [];
}

class AddSectionTrainerInitial extends AddSectionTrainerState{}
class AddSectionTrainerLoading extends AddSectionTrainerState{}
class AddSectionTrainerFailure extends AddSectionTrainerState{
  final String errorMessage;

  const AddSectionTrainerFailure(this.errorMessage);
}
class AddSectionTrainerSuccess extends AddSectionTrainerState{
  final AddSectionTrainerModel addResult;

  const AddSectionTrainerSuccess(this.addResult);
}