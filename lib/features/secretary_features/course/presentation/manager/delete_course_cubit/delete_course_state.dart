import 'package:equatable/equatable.dart';

import '../../../data/models/delete_course_model.dart';

abstract class DeleteCourseState extends Equatable{
  const DeleteCourseState();

  @override
  List<Object?> get props => [];
}

class DeleteCourseInitial extends DeleteCourseState{}
class DeleteCourseLoading extends DeleteCourseState{}
class DeleteCourseFailure extends DeleteCourseState{
  final String errorMessage;

  const DeleteCourseFailure(this.errorMessage);
}
class DeleteCourseSuccess extends DeleteCourseState{
  final DeleteCourseModel deleteResult;

  const DeleteCourseSuccess(this.deleteResult);
}