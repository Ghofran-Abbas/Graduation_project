import 'package:equatable/equatable.dart';

import '../../../data/models/update_state_section_model.dart';

abstract class UpdateStateSectionState extends Equatable{
  const UpdateStateSectionState();

  @override
  List<Object> get props => [];
}
class UpdateStateSectionInitial extends UpdateStateSectionState {}
class UpdateStateSectionLoading extends UpdateStateSectionState {}
class UpdateStateSectionFailure extends UpdateStateSectionState {
  final String errorMessage;

  const UpdateStateSectionFailure(this.errorMessage);
}
class UpdateStateSectionSuccess extends UpdateStateSectionState {
  final UpdateStateSectionModel updateResult;

  const UpdateStateSectionSuccess(this.updateResult);
}