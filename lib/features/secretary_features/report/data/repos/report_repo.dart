import 'dart:typed_data';

import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/data/models/create_report_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/data/models/details_report_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/data/models/reports_model.dart';
import 'package:dartz/dartz.dart';

import '../models/update_report_model.dart';

abstract class ReportRepo {
  Future<Either<Failure, ReportsModel>> fetchReports({required int page});

  Future<Either<Failure, CreateReportModel>> fetchCreateReport({
    required String name,
    required String description,
    required String fileName,
    required Uint8List file,
  });

  Future<Either<Failure, DetailsReportModel>> fetchDetailsReport({required int id});

  Future<Either<Failure, UpdateReportModel>> fetchUpdateReport({
    required int id,
    String? name,
    String? description,
    String? fileName,
    Uint8List? file,
  });
}