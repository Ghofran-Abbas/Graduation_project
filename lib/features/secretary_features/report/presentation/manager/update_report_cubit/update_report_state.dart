import 'package:equatable/equatable.dart';

import '../../../data/models/update_report_model.dart';

abstract class UpdateReportState extends Equatable {
  const UpdateReportState();

  @override
  List<Object?> get props => [];
}

class UpdateReportInitial extends UpdateReportState {}
class UpdateReportLoading extends UpdateReportState {}
class UpdateReportFailure extends UpdateReportState {
  final String errorMessage;

  const UpdateReportFailure(this.errorMessage);
}
class UpdateReportSuccess extends UpdateReportState {
  final UpdateReportModel updateReport;

  const UpdateReportSuccess(this.updateReport);
}