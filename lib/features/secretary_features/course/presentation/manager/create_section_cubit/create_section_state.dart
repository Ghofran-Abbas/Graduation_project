import 'package:alhadara_dashboard/features/secretary_features/course/data/models/create_section_model.dart';
import 'package:equatable/equatable.dart';

abstract class CreateSectionState extends Equatable{
  const CreateSectionState();

  @override
  List<Object> get props => [];
}
class CreateSectionInitial extends CreateSectionState {}
class CreateSectionLoading extends CreateSectionState {}
class CreateSectionFailure extends CreateSectionState {
  final String errorMessage;

  const CreateSectionFailure(this.errorMessage);
}
class CreateSectionSuccess extends CreateSectionState {
  final CreateSectionModel createResult;

  const CreateSectionSuccess(this.createResult);
}



//MultiCheckboxState
class MultiCheckboxState {
  final List<String> selectedItems;

  MultiCheckboxState({required this.selectedItems});
}

//SingleCheckboxState
abstract class SingleCheckboxState {}

class SingleCheckboxInitial extends SingleCheckboxState {}

class SingleCheckboxUpdated extends SingleCheckboxState {
  final String selectedItem;

  SingleCheckboxUpdated(this.selectedItem);
}