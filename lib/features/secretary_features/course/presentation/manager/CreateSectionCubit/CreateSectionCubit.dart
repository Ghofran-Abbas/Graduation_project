import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'CreateSectionState.dart';

class CreateSectionCubit extends Cubit<CreateSectionState> {

  static CreateSectionCubit get(context) => BlocProvider.of(context);

  CreateSectionCubit(this.courseRepo) : super(CreateSectionInitial());

  final CourseRepo courseRepo;

  IconData suffixIcon = Icons.visibility_off;
  bool isPassShow = true;



  void changePassVisibility() {
    isPassShow = !isPassShow;
    suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
    emit(ChangePassVisibilityState());
  }

}

//MultiCheckboxCubit
class MultiCheckboxCubit extends Cubit<MultiCheckboxState> {
  MultiCheckboxCubit() : super(MultiCheckboxState(selectedItems: []));


  void toggleItem(String item) {
    final isSelected = state.selectedItems.contains(item);
    final updatedList = isSelected
        ? state.selectedItems.where((i) => i != item).toList()
        : [...state.selectedItems, item];

    log(updatedList.toString());

    emit(MultiCheckboxState(selectedItems: updatedList));
  }
}

//SingleCheckboxCubit
class SingleCheckboxCubit extends Cubit<SingleCheckboxState> {
  SingleCheckboxCubit() : super(SingleCheckboxInitial());

  static SingleCheckboxCubit get(BuildContext context) => BlocProvider.of(context);

  String? selectedItem;

  void selectItem(String item) {
    selectedItem = item;
    emit(SingleCheckboxUpdated(item));
  }
}
