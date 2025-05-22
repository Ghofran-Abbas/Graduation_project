import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/student_repo.dart';
import 'search_student_state.dart';

class SearchStudentCubit extends Cubit<SearchStudentState>{
  static SearchStudentState get(context) => BlocProvider.of(context);

  final StudentRepo studentRepo;

  SearchStudentCubit(this.studentRepo) : super(SearchStudentInitial());

  Future<void> fetchSearchStudent({required String querySearch, required int page}) async {
    emit(SearchStudentLoading());
    var result = await studentRepo.fetchSearchStudent(querySearch: querySearch, page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(SearchStudentFailure(failure.errorMessage));
    }, (student) {
      emit(SearchStudentSuccess(student));
    });
  }
}