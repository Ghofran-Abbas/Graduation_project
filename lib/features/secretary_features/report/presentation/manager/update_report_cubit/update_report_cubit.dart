import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'update_report_state.dart';

class UpdateReportCubit extends Cubit<UpdateReportState>{
  static UpdateReportCubit get(context) => BlocProvider.of(context);

  final ReportRepo reportRepo;

  UpdateReportCubit(this.reportRepo) : super(UpdateReportInitial());

  Future<void> fetchUpdateReport({
    required int id,
    String? name,
    String? description,
    String? fileName,
    Uint8List? file,
  }) async {
    emit(UpdateReportLoading());
    var result = await reportRepo.fetchUpdateReport(
      id: id,
      name: name,
      description: description,
      fileName: fileName,
      file: file
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(UpdateReportFailure(failure.errorMessage));
    }, (updateReport) {
      emit(UpdateReportSuccess(updateReport));
    });
  }
}