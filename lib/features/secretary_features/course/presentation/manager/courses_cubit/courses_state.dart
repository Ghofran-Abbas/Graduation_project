import 'package:equatable/equatable.dart';

import '../../../data/models/courses_model.dart';

abstract class CoursesState extends Equatable{
  const CoursesState();
  
  @override
  List<Object?> get props => [];
}

class CoursesInitial extends CoursesState{}
class CoursesLoading extends CoursesState{}
class CoursesFailure extends CoursesState{
  final String errorMessage;

  const CoursesFailure(this.errorMessage);
}
class CoursesSuccess extends CoursesState{
  final CoursesModel courses;

  const CoursesSuccess(this.courses);
}