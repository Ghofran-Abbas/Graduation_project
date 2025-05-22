import 'package:alhadara_dashboard/features/secretary_features/course/data/models/details_course_model.dart';
import 'package:equatable/equatable.dart';

abstract class DetailsCourseState extends Equatable{
  const DetailsCourseState();

  @override
  List<Object?> get props => [];
}

class DetailsCourseInitial extends DetailsCourseState{}
class DetailsCourseLoading extends DetailsCourseState{}
class DetailsCourseFailure extends DetailsCourseState{
  final String errorMessage;

  const DetailsCourseFailure(this.errorMessage);
}
class DetailsCourseSuccess extends DetailsCourseState{
  final DetailsCourseModel course;

  const DetailsCourseSuccess(this.course);
}