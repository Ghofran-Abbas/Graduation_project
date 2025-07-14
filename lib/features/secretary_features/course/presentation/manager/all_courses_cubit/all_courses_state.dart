import 'package:equatable/equatable.dart';

import '../../../data/models/all_courses_model.dart';

abstract class AllCoursesState extends Equatable{
  const AllCoursesState();

  @override
  List<Object?> get props => [];
}

class AllCoursesInitial extends AllCoursesState{}
class AllCoursesLoading extends AllCoursesState{}
class AllCoursesFailure extends AllCoursesState{
  final String errorMessage;

  const AllCoursesFailure(this.errorMessage);
}
class AllCoursesSuccess extends AllCoursesState{
  final AllCoursesModel allCourses;

  const AllCoursesSuccess(this.allCourses);
}