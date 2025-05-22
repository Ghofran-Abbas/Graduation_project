import 'package:alhadara_dashboard/features/secretary_features/report/data/models/reports_model.dart';
import 'package:equatable/equatable.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object?> get props => [];
}

class ReportsInitial extends ReportsState {}
class ReportsLoading extends ReportsState {}
class ReportsFailure extends ReportsState {
  final String errorMessage;

  const ReportsFailure(this.errorMessage);
}
class ReportsSuccess extends ReportsState {
  final ReportsModel reports;

  const ReportsSuccess(this.reports);
}