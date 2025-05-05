import 'package:equatable/equatable.dart';

abstract class CreateSectionState extends Equatable{
  const CreateSectionState();

  @override
  List<Object> get props => [];
}
class CreateSectionInitial extends CreateSectionState {}
class ChangePassVisibilityState extends CreateSectionState {}

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