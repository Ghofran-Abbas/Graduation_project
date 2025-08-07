import 'package:equatable/equatable.dart';

import '../../../data/models/complete_model.dart';

abstract class CompleteState extends Equatable{
  const CompleteState();

  @override
  List<Object?> get props => [];
}

class CompleteInitial extends CompleteState{}
class CompleteLoading extends CompleteState{}
class CompleteFailure extends CompleteState{
  final String errorMessage;

  const CompleteFailure(this.errorMessage);
}
class CompleteSuccess extends CompleteState{
  final CompleteModel createResult;
  final int currentPage;
  final int lastPage;

  const CompleteSuccess({required this.createResult, required this.currentPage, required this.lastPage,});

  @override
  List<Object?> get props => [createResult, currentPage, lastPage];
}

abstract class SelectCompleteState extends Equatable{
  const SelectCompleteState();

  @override
  List<Object?> get props => [];
}

class SelectSectionInitial extends SelectCompleteState{}
class SelectCompleteSuccess extends SelectCompleteState {
  final DatumComplete section;
  final DateTime timestamp;

  SelectCompleteSuccess(this.section) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [section, timestamp];
}