import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'details_section_state.dart';

class DetailsSectionCubit extends Cubit<DetailsSectionState>{
  static DetailsSectionState get(context) => BlocProvider.of(context);

  final CourseRepo sectionRepo;

  DetailsSectionCubit(this.sectionRepo) : super(DetailsSectionInitial());

  Future<void> fetchDetailsSection({required int id}) async {
    emit(DetailsSectionLoading());
    var result = await sectionRepo.fetchDetailsSection(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DetailsSectionFailure(failure.errorMessage));
    }, (section) {
      emit(DetailsSectionSuccess(section));
    });
  }
}