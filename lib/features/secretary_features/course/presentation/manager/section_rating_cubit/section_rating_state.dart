import 'package:equatable/equatable.dart';

import '../../../data/models/section_rating_model.dart';

abstract class SectionRatingState extends Equatable{
  const SectionRatingState();

  @override
  List<Object?> get props => [];
}

class SectionRatingInitial extends SectionRatingState{}
class SectionRatingLoading extends SectionRatingState{}
class SectionRatingFailure extends SectionRatingState{
  final String errorMessage;

  const SectionRatingFailure(this.errorMessage);
}
class SectionRatingSuccess extends SectionRatingState{
  final SectionRatingModel sectionRating;

  const SectionRatingSuccess(this.sectionRating);
}
