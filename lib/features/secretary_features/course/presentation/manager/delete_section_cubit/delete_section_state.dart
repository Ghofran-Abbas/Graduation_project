import 'package:alhadara_dashboard/features/secretary_features/course/data/models/delete_section_model.dart';
import 'package:equatable/equatable.dart';

abstract class DeleteSectionState extends Equatable{
  const DeleteSectionState();

  @override
  List<Object?> get props => [];
}

class DeleteSectionInitial extends DeleteSectionState{}
class DeleteSectionLoading extends DeleteSectionState{}
class DeleteSectionFailure extends DeleteSectionState{
  final String errorMessage;

  const DeleteSectionFailure(this.errorMessage);
}
class DeleteSectionSuccess extends DeleteSectionState{
  final DeleteSectionModel deleteResult;

  const DeleteSectionSuccess(this.deleteResult);
}