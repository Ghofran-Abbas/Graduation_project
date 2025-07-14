import 'package:equatable/equatable.dart';

import '../../../data/models/section_progress_model.dart';

abstract class SectionProgressState extends Equatable{
  const SectionProgressState();

  @override
  List<Object?> get props => [];
}

class SectionProgressInitial extends SectionProgressState{}
class SectionProgressLoading extends SectionProgressState{}
class SectionProgressFailure extends SectionProgressState{
  final String errorMessage;

  const SectionProgressFailure(this.errorMessage);
}
class SectionProgressSuccess extends SectionProgressState{
  final SectionProgressModel sectionProgress;

  const SectionProgressSuccess(this.sectionProgress);
}