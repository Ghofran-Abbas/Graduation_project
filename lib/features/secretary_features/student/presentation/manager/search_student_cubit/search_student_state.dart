import 'package:equatable/equatable.dart';

import '../../../data/models/search_student_model.dart';

abstract class SearchStudentState extends Equatable{
  const SearchStudentState();

  @override
  List<Object?> get props => [];
}

class SearchStudentInitial extends SearchStudentState{}
class SearchStudentLoading extends SearchStudentState{}
class SearchStudentFailure extends SearchStudentState{
  final String errorMessage;

  const SearchStudentFailure(this.errorMessage);
}
class SearchStudentSuccess extends SearchStudentState{
  final SearchStudentModel student;

  const SearchStudentSuccess(this.student);
}