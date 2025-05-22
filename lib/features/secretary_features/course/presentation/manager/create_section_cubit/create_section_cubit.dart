import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'create_section_state.dart';

class CreateSectionCubit extends Cubit<CreateSectionState> {

  static CreateSectionCubit get(context) => BlocProvider.of(context);

  CreateSectionCubit(this.courseRepo) : super(CreateSectionInitial());

  final CourseRepo courseRepo;

  Future<void> fetchCreateSection({
    required int courseId,
    required String name,
    required int seatsOfNumber,
    required String startDate,
    required String endDate,
    required Map<String, dynamic>? sunday,
    required Map<String, dynamic>? monday,
    required Map<String, dynamic>? tuesday,
    required Map<String, dynamic>? wednesday,
    required Map<String, dynamic>? thursday,
    required Map<String, dynamic>? friday,
    required Map<String, dynamic>? saturday,
  }) async {
    emit(CreateSectionLoading());
    var result = await courseRepo.fetchCreateSection(
      courseId: courseId,
      name: name,
      seatsOfNumber: seatsOfNumber,
      startDate: startDate,
      endDate: endDate,
      sunday: sunday,
      monday: monday,
      tuesday: tuesday,
      wednesday: wednesday,
      thursday: thursday,
      friday: friday,
      saturday: saturday,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CreateSectionFailure(failure.errorMessage));
    }, (createResult) {
      emit(CreateSectionSuccess(createResult));
    });
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
