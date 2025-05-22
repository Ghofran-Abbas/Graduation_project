import 'package:equatable/equatable.dart';

import '../../../data/models/update_section_model.dart';

abstract class UpdateSectionState extends Equatable{
  const UpdateSectionState();

  @override
  List<Object> get props => [];
}
class UpdateSectionInitial extends UpdateSectionState {}
class UpdateSectionLoading extends UpdateSectionState {}
class UpdateSectionFailure extends UpdateSectionState {
  final String errorMessage;

  const UpdateSectionFailure(this.errorMessage);
}
class UpdateSectionSuccess extends UpdateSectionState {
  final UpdateSectionModel updateResult;

  const UpdateSectionSuccess(this.updateResult);
}