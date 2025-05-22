import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/report_repo.dart';
import 'create_report_state.dart';

class CreateReportCubit extends Cubit<CreateReportState>{
  static CreateReportCubit get(context) => BlocProvider.of(context);

  final ReportRepo reportRepo;

  CreateReportCubit(this.reportRepo) : super(CreateReportInitial());

  Future<void> fetchCreateReport({
    required String name,
    required String description,
    required String fileName,
    required Uint8List file,
  }) async {
    emit(CreateReportLoading());
    var result = await reportRepo.fetchCreateReport(
      name: name,
      description: description,
      fileName: fileName,
      file: file
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CreateReportFailure(failure.errorMessage));
    }, (createReport) {
      emit(CreateReportSuccess(createReport));
    });
  }
}