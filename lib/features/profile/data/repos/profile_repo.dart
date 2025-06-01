import 'package:alhadara_dashboard/features/profile/data/model/gifts_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../model/details_gift_model.dart';
import '../model/points_model.dart';

abstract class ProfileRepo {

  Future<Either<Failure, GiftsModel>> fetchGifts({required int page});

  Future<Either<Failure, DetailsGiftModel>> fetchDetailsGift({required int id,});

  Future<Either<Failure, PointsModel>> fetchPoints();
}