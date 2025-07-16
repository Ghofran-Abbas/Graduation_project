import 'package:equatable/equatable.dart';

import '../../../data/models/archive_section_trainer_model.dart';

abstract class ArchiveTrainerState extends Equatable {
  const ArchiveTrainerState();

  @override
  List<Object> get props => [];
}

class ArchiveTrainerInitial extends ArchiveTrainerState {}
class ArchiveTrainerLoading extends ArchiveTrainerState {}
class ArchiveTrainerFailure extends ArchiveTrainerState {
  final String errorMessage;

  const ArchiveTrainerFailure(this.errorMessage);
}
class ArchiveTrainerSuccess extends ArchiveTrainerState {
  final ArchiveSectionTrainerModel showResult;

  const ArchiveTrainerSuccess(this.showResult);
}