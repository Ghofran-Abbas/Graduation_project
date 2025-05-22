import 'package:equatable/equatable.dart';

import '../../../../trainer/data/models/search_trainer_model.dart';

abstract class SearchTrainerState extends Equatable{
  const SearchTrainerState();

  @override
  List<Object?> get props => [];
}

class SearchTrainerInitial extends SearchTrainerState{}
class SearchTrainerLoading extends SearchTrainerState{}
class SearchTrainerFailure extends SearchTrainerState{
  final String errorMessage;

  const SearchTrainerFailure(this.errorMessage);
}
class SearchTrainerSuccess extends SearchTrainerState{
  final SearchTrainerModel trainer;

  const SearchTrainerSuccess(this.trainer);
}