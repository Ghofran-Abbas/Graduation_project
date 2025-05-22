import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/report/data/repos/report_repo.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/presentation/manager/reports_cubit/reports_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsCubit extends Cubit<ReportsState>{
  static ReportsCubit get(context) => BlocProvider.of(context);

  final ReportRepo reportRepo;

  ReportsCubit(this.reportRepo) : super(ReportsInitial());

  Future<void> fetchReports({required int page}) async {
    emit(ReportsLoading());
    var result = await reportRepo.fetchReports(page: page);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ReportsFailure(failure.errorMessage));
    }, (reports) {
      emit(ReportsSuccess(reports));
    });
  }
}