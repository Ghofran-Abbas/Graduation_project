import 'package:equatable/equatable.dart';

import '../../../data/models/trainer_rating_model.dart';

abstract class TrainerRatingState extends Equatable{
  const TrainerRatingState();

  @override
  List<Object?> get props => [];
}

class TrainerRatingInitial extends TrainerRatingState{}
class TrainerRatingLoading extends TrainerRatingState{}
class TrainerRatingFailure extends TrainerRatingState{
  final String errorMessage;

  const TrainerRatingFailure(this.errorMessage);
}
class TrainerRatingSuccess extends TrainerRatingState{
  final TrainerRatingModel trainerRating;

  const TrainerRatingSuccess(this.trainerRating);
}