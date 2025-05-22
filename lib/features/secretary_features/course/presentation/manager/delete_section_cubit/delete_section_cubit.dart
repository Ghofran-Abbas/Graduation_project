import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/course/data/repos/course_repo.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/delete_section_cubit/delete_section_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteSectionCubit extends Cubit<DeleteSectionState>{
  static DeleteSectionCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  DeleteSectionCubit(this.courseRepo) : super(DeleteSectionInitial());

  Future<void> fetchDeleteSection({required int id}) async {
    emit(DeleteSectionLoading());
    var result = await courseRepo.fetchDeleteSection(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DeleteSectionFailure(failure.errorMessage));
    }, (deleteResult) {
      emit(DeleteSectionSuccess(deleteResult));
    });
  }
}