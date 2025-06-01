import 'package:equatable/equatable.dart';

import '../../../data/model/points_model.dart';

abstract class PointsState extends Equatable{
  const PointsState();

  @override
  List<Object?> get props => [];
}

class PointsInitial extends PointsState{}
class PointsLoading extends PointsState{}
class PointsFailure extends PointsState{
  final String errorMessage;

  const PointsFailure(this.errorMessage);
}
class PointsSuccess extends PointsState{
  final PointsModel points;

  const PointsSuccess(this.points);
}