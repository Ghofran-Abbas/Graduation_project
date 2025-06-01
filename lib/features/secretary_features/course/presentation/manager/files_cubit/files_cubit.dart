import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/course_repo.dart';
import 'files_state.dart';

class FilesCubit extends Cubit<FilesState>{

  static FilesCubit get(context) => BlocProvider.of(context);

  final CourseRepo courseRepo;

  FilesCubit(this.courseRepo) : super(FilesInitial());

  Future<void> fetchFiles({required int sectionId, required int page}) async {
    emit(FilesLoading());
    var result = await courseRepo.fetchFiles(
      sectionId: sectionId,
      page: page,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(FilesFailure(failure.errorMessage));
    }, (files) {
      emit(FilesSuccess(files));
    });
  }
}