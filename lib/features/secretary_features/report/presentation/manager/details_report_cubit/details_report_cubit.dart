
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'details_report_state.dart';

class DetailsReportCubit extends Cubit<DetailsReportState>{
  static DetailsReportCubit get(context) => BlocProvider.of(context);

  final ReportRepo reportRepo;

  DetailsReportCubit(this.reportRepo) : super(DetailsReportInitial());

  Future<void> fetchDetailsReport({
    required int id,
  }) async {
    emit(DetailsReportLoading());
    var result = await reportRepo.fetchDetailsReport(id: id,);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DetailsReportFailure(failure.errorMessage));
    }, (report) {
      emit(DetailsReportSuccess(report));
    });
  }
}