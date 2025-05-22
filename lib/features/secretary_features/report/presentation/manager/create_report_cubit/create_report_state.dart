import 'package:equatable/equatable.dart';

import '../../../data/models/create_report_model.dart';

abstract class CreateReportState extends Equatable {
  const CreateReportState();

  @override
  List<Object?> get props => [];
}

class CreateReportInitial extends CreateReportState {}
class CreateReportLoading extends CreateReportState {}
class CreateReportFailure extends CreateReportState {
  final String errorMessage;

  const CreateReportFailure(this.errorMessage);
}
class CreateReportSuccess extends CreateReportState {
  final CreateReportModel createReport;

  const CreateReportSuccess(this.createReport);
}