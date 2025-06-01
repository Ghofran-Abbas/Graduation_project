import 'package:equatable/equatable.dart';

import '../../../data/models/files_model.dart';

abstract class FilesState extends Equatable{
  const FilesState();

  @override
  List<Object?> get props => [];
}

class FilesInitial extends FilesState{}
class FilesLoading extends FilesState{}
class FilesFailure extends FilesState{
  final String errorMessage;

  const FilesFailure(this.errorMessage);
}
class FilesSuccess extends FilesState{
  final FilesModel files;

  const FilesSuccess(this.files);
}