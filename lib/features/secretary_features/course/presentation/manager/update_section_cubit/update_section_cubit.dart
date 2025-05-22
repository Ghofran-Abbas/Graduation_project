import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'update_section_state.dart';

class UpdateSectionCubit extends Cubit<UpdateSectionState>{
  static UpdateSectionCubit get(context) => BlocProvider.of(context);

  UpdateSectionCubit(this.courseRepo) : super(UpdateSectionInitial());

  final CourseRepo courseRepo;

  Future<void> fetchUpdateSection({
    required int courseId,
    String? name,
    int? seatsOfNumber,
    String? startDate,
    String? endDate,
    String? state,
    Map<String, dynamic>? sunday,
    Map<String, dynamic>? monday,
    Map<String, dynamic>? tuesday,
    Map<String, dynamic>? wednesday,
    Map<String, dynamic>? thursday,
    Map<String, dynamic>? friday,
    Map<String, dynamic>? saturday,
  }) async {
    emit(UpdateSectionLoading());
    var result = await courseRepo.fetchUpdateSection(
      courseId: courseId,
      name: name,
      seatsOfNumber: seatsOfNumber,
      startDate: startDate,
      endDate: endDate,
      state: state,
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
      emit(UpdateSectionFailure(failure.errorMessage));
    }, (updateResult) {
      emit(UpdateSectionSuccess(updateResult));
    });
  }
}