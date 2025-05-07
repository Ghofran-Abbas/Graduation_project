import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/student/data/repos/student_repo.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/update_student_cubit/update_student_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateStudentCubit extends Cubit<UpdateStudentState>{
  static UpdateStudentState get(context) => BlocProvider.of(context);

  UpdateStudentCubit(this.studentRepo,) : super(UpdateStudentInitial());

  final StudentRepo studentRepo;

  Future<void> fetchUpdateStudent({
    required int id,
    String? name,
    String? phone,
    String? birthday,
    String? gender,
    Uint8List? photo,
}) async {
    emit(UpdateStudentLoading());
    var result = await studentRepo.fetchUpdateStudent(
        id: id,
        name: name,
        phone: phone,
        birthday: birthday,
        gender: gender,
        photo: photo,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(UpdateStudentFailure(failure.errorMessage));
    }, (updateResult) {
      emit(UpdateStudentSuccess(updateResult));
    });
  }
}