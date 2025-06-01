import 'dart:developer';

import 'package:alhadara_dashboard/core/errors/failure.dart';
import 'package:alhadara_dashboard/core/utils/shared_preferences_helper.dart';
import 'package:alhadara_dashboard/features/profile/data/model/details_gift_model.dart';
import 'package:alhadara_dashboard/features/profile/data/model/gifts_model.dart';
import 'package:alhadara_dashboard/features/profile/data/model/points_model.dart';
import 'package:alhadara_dashboard/features/profile/data/repos/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../constants.dart';
import '../../../../core/utils/api_service.dart';

class ProfileRepoImpl extends ProfileRepo{
  final DioApiService dioApiService;

  ProfileRepoImpl(this.dioApiService);

  @override
  Future<Either<Failure, GiftsModel>> fetchGifts({required int page}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/gifts?page=$page',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      GiftsModel giftsModel;
      giftsModel = GiftsModel.fromJson(data);

      return right(giftsModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DetailsGiftModel>> fetchDetailsGift({required int id}) async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/admin/gifts/$id',
        token: Constants.adminToken,
      ));
      log(data.toString());
      DetailsGiftModel detailsGiftModel;
      detailsGiftModel = DetailsGiftModel.fromJson(data);

      return right(detailsGiftModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PointsModel>> fetchPoints() async {
    try {
      var data = await (dioApiService.get(
        endPoint: '/secretary/points',
        token: await SharedPreferencesHelper.getJwtToken(),
      ));
      log(data.toString());
      PointsModel pointsModel;
      pointsModel = PointsModel.fromJson(data);

      return right(pointsModel);

    } catch (e) {
      if (e is DioException){
        return left(ServerFailure.fromDioError(e),);
      }
      return left(ServerFailure(e.toString()));
    }
  }
}