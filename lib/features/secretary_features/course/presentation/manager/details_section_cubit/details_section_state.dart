import 'package:equatable/equatable.dart';

import '../../../data/models/details_section_model.dart';

abstract class DetailsSectionState extends Equatable{
  const DetailsSectionState();

  @override
  List<Object?> get props => [];
}

class DetailsSectionInitial extends DetailsSectionState{}
class DetailsSectionLoading extends DetailsSectionState{}
class DetailsSectionFailure extends DetailsSectionState{
  final String errorMessage;

  const DetailsSectionFailure(this.errorMessage);
}
class DetailsSectionSuccess extends DetailsSectionState{
  final DetailsSectionModel section;

  const DetailsSectionSuccess(this.section);
}