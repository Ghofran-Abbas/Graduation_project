import 'package:equatable/equatable.dart';

import '../../../data/models/in_preparation_model.dart';

abstract class InPreparationState extends Equatable{
  const InPreparationState();

  @override
  List<Object?> get props => [];
}

class InPreparationInitial extends InPreparationState{}
class InPreparationLoading extends InPreparationState{}
class InPreparationFailure extends InPreparationState{
  final String errorMessage;

  const InPreparationFailure(this.errorMessage);
}
class InPreparationSuccess extends InPreparationState{
  final InPreparationModel createResult;
  final int currentPage;
  final int lastPage;

  const InPreparationSuccess({required this.createResult, required this.currentPage, required this.lastPage,});
}



abstract class SelectInPreparationState extends Equatable{
  const SelectInPreparationState();

  @override
  List<Object?> get props => [];
}

class SelectSectionInitial extends SelectInPreparationState{}
class SelectInPreparationSuccess extends SelectInPreparationState {
  final DatumInPreparation section;
  final DateTime timestamp;

  SelectInPreparationSuccess(this.section) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [section, timestamp];
}