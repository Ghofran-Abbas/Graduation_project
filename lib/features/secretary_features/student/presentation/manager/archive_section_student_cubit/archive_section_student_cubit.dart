import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/student_repo.dart';
import 'archive_section_student_state.dart';

class ArchiveStudentCubit extends Cubit<ArchiveStudentState> {

  static ArchiveStudentCubit get(context) => BlocProvider.of(context);

  ArchiveStudentCubit(this.studentRepo,) : super(ArchiveStudentInitial());

  final StudentRepo studentRepo;

  Future<void> fetchArchiveStudent({required int id, required int page}) async {
    emit(ArchiveStudentLoading());
    var result = await studentRepo.fetchArchiveStudent(id: id, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ArchiveStudentFailure(failure.errorMessage));
    }, (archiveStudent) {
      emit(ArchiveStudentSuccess(archiveStudent));
    },
    );
  }
}