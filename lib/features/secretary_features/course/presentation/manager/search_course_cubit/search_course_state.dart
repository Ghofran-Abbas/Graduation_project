import 'package:equatable/equatable.dart';

import '../../../data/models/search_course_model.dart';

abstract class SearchCourseState extends Equatable{
  const SearchCourseState();

  @override
  List<Object?> get props => [];
}

class SearchCourseInitial extends SearchCourseState{}
class SearchCourseLoading extends SearchCourseState{}
class SearchCourseFailure extends SearchCourseState{
  final String errorMessage;

  const SearchCourseFailure(this.errorMessage);
}
class SearchCourseSuccess extends SearchCourseState{
  final SearchCourseModel course;

  const SearchCourseSuccess(this.course);
}