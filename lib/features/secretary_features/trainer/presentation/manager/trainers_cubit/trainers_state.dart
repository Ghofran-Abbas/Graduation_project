import 'package:alhadara_dashboard/features/secretary_features/student/data/models/create_student_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../data/models/trainers_model.dart';


abstract class TrainersState extends Equatable {
  const TrainersState();

  @override
  List<Object> get props => [];
}

class TrainersInitial extends TrainersState {}
class TrainersLoading extends TrainersState {}
class TrainersFailure extends TrainersState {
  final String errorMessage;

  const TrainersFailure(this.errorMessage);
}
class TrainersSuccess extends TrainersState {
  final TrainersModel showResult;

  const TrainersSuccess(this.showResult);
}