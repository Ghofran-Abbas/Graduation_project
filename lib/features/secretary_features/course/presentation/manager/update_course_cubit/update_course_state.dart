import 'package:equatable/equatable.dart';

import '../../../data/models/update_course_model.dart';

abstract class UpdateCourseState extends Equatable{
  const UpdateCourseState();

  @override
  List<Object> get props => [];
}

class UpdateCourseInitial extends UpdateCourseState{}
class UpdateCourseLoading extends UpdateCourseState{}
class UpdateCourseFailure extends UpdateCourseState{
  final String errorMessage;

  const UpdateCourseFailure(this.errorMessage);
}
class UpdateCourseSuccess extends UpdateCourseState{
  final UpdateCourseModel updateResult;

  const UpdateCourseSuccess(this.updateResult);
}

