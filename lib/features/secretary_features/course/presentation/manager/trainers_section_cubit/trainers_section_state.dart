import 'package:equatable/equatable.dart';

import '../../../data/models/trainers_section_model.dart';

abstract class TrainersSectionState extends Equatable{
  const TrainersSectionState();

  @override
  List<Object> get props => [];
}
class TrainersSectionInitial extends TrainersSectionState {}
class TrainersSectionLoading extends TrainersSectionState {}
class TrainersSectionFailure extends TrainersSectionState {
  final String errorMessage;

  const TrainersSectionFailure(this.errorMessage);
}
class TrainersSectionSuccess extends TrainersSectionState {
  final TrainersSectionModel trainers;

  const TrainersSectionSuccess(this.trainers);
}