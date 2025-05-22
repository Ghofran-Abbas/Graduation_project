import 'package:alhadara_dashboard/features/secretary_features/department/data/models/details_department_model.dart';
import 'package:equatable/equatable.dart';

abstract class DetailsDepartmentState extends Equatable{
  const DetailsDepartmentState();

  @override
  List<Object?> get props => [];
}

class DetailsDepartmentInitial extends DetailsDepartmentState{}
class DetailsDepartmentLoading extends DetailsDepartmentState{}
class DetailsDepartmentFailure extends DetailsDepartmentState{
  final String errorMessage;

  const DetailsDepartmentFailure(this.errorMessage);
}
class DetailsDepartmentSuccess extends DetailsDepartmentState{
  final DetailsDepartmentModel showResult;

  const DetailsDepartmentSuccess(this.showResult);
}