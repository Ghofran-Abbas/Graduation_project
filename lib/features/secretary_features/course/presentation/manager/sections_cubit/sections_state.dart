import 'package:equatable/equatable.dart';

import '../../../data/models/sections_model.dart';

abstract class SectionsState extends Equatable{
  const SectionsState();

  @override
  List<Object?> get props => [];
}

class SectionsInitial extends SectionsState{}
class SectionsLoading extends SectionsState{}
class SectionsFailure extends SectionsState{
  final String errorMessage;

  const SectionsFailure(this.errorMessage);
}
class SectionsSuccess extends SectionsState{
  final SectionsModel createResult;

  const SectionsSuccess(this.createResult);
}



abstract class SelectSectionState extends Equatable{
  const SelectSectionState();

  @override
  List<Object?> get props => [];
}

class SelectSectionInitial extends SelectSectionState{}
class SelectSectionSuccess extends SelectSectionState {
  final Section section;
  final DateTime timestamp;

  SelectSectionSuccess(this.section) : timestamp = DateTime.now();

  @override
  List<Object?> get props => [section, timestamp]; // اضف timestamp للمقارنة
}