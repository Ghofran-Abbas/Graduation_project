import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/api_service.dart';
import 'package:alhadara_dashboard/core/utils/shared_preferences_helper.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/data/models/create_report_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/data/models/details_report_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/data/models/reports_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/data/models/update_report_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';

import 'report_repo.dart';

class ReportRepoImpl extends ReportRepo {
  final DioApiService dioApiService;

  ReportRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, ReportsModel>> fetchReports({required int page}) async {
    try {
      var data = await dioApiService.get(
        endPoint: '/secretary/my-reports/?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      );
      log(data.toString());
      ReportsModel reportsModel;
      reportsModel = ReportsModel.fromJson(data);

      return right(reportsModel);

    } catch(e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateReportModel>> fetchCreateReport({
    required String name,
    required String description,
    required String fileName,
    required Uint8List file,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "description": description,
        "file": MultipartFile.fromBytes(
          file,
          filename: fileName,
        ),
      });

      var data = await dioApiService.postWithImage(
          endPoint: '/secretary/reports',
          data: formData,
          token: await SharedPreferencesHelper.getJwtToken(),
    );
    log(data.toString());
    CreateReportModel createReportModel;
    createReportModel = CreateReportModel.fromJson(data);

    return right(createReportModel);

    } catch(e) {
    if (e is DioException){
    return left(ServerFailure.fromDioError(e),);
    }
    return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsReportModel>> fetchDetailsReport({required int id}) async {
    try {
      var data = await dioApiService.get(
        endPoint: '/secretary/reports/$id',
        token: await SharedPreferencesHelper.getJwtToken(),
      );
      log(data.toString());
      DetailsReportModel detailsReportModel;
      detailsReportModel = DetailsReportModel.fromJson(data);

      return right(detailsReportModel);

    } catch(e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdateReportModel>> fetchUpdateReport({
    required int id,
    String? name,
    String? description,
    String? fileName,
    Uint8List? file,
  }) async {
    try {
      final Map<String, dynamic> dataMap = {};

      if (name != null && name.trim().isNotEmpty) {
        dataMap['name'] = name;
      }

      if (description != null && description.trim().isNotEmpty) {
        dataMap['description'] = description;
      }

      if (file != null) {
        dataMap['file'] = MultipartFile.fromBytes(
          file,
          filename: fileName,
        );
      }

      if (dataMap.isEmpty) {
        return left(ServerFailure('يجب تعديل حقل واحد على الأقل قبل الإرسال.'));
      }

      final formData = FormData.fromMap(dataMap);

      var data = await dioApiService.postWithImage(
        endPoint: '/secretary/reports/$id',
        data: formData,
        token: await SharedPreferencesHelper.getJwtToken(),
      );
      log(data.toString());
      UpdateReportModel updateReportModel;
      updateReportModel = UpdateReportModel.fromJson(data);

      return right(updateReportModel);

    } catch(e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchFile({
    required String filePath,
  }) async {
    try{
      var response = await dioApiService.getFile(
        endPoint: "http://127.0.0.1:8080/$filePath",
      );

      if (response.statusCode == 200) {
        final contentDisposition = response.headers['content-disposition']?.first;
        final filename = contentDisposition?.split('filename=')[1] ?? 'data';
        final bytes = response.data as Uint8List;

        await FileSaver.instance.saveFile(
          name: filename,
          bytes: bytes,
          ext: filePath,
          mimeType: MimeType.microsoftExcel,
        );

        return right(response);
      } else {
        throw Exception('Export failed with status: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }
}