import 'dart:developer';

import 'package:alhadara_dashboard/features/secretary_features/department/data/repos/department_repo.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/presentation/manager/details_department_cubit/details_department_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsDepartmentCubit extends Cubit<DetailsDepartmentState>{

  static DetailsDepartmentCubit get(context) => BlocProvider.of(context);

  final DepartmentRepo departmentsRepo;

  DetailsDepartmentCubit(this.departmentsRepo) : super(DetailsDepartmentInitial());

  Future<void> fetchDetailsDepartment({required int id}) async {
    emit(DetailsDepartmentLoading());
    var result = await departmentsRepo.fetchDetailsDepartment(id: id);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(DetailsDepartmentFailure(failure.errorMessage));
    }, (detailsDepartment) {
      emit(DetailsDepartmentSuccess(detailsDepartment));
    });
  }
}