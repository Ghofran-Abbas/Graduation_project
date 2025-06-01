import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/student/data/repos/student_repo.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/create_student_cubit/create_student_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateStudentCubit extends Cubit<CreateStudentState> {

  static CreateStudentCubit get(context) => BlocProvider.of(context);

  CreateStudentCubit(this.studentRepo,) : super(CreateStudentInitial());

  final StudentRepo studentRepo;

  /*IconData suffixIcon = Icons.visibility_off;
  bool isPassShow = true;

  void changePassVisibility() {
    isPassShow = !isPassShow;
    suffixIcon = isPassShow ? Icons.visibility_off : Icons.visibility;
    emit(ChangePassVisibilityState());
  }*/

  Future<void> fetchCreateStudent({
    required String name,
    required String email,
    required String phone,
    required String password,
    required Uint8List photo,
    required String birthday,
    required String gender,
    int? referredId,
  }) async {
    emit(CreateStudentLoading());
    var result = await studentRepo.fetchCreateStudent(
      name: name,
      email: email,
      password: password,
      phone: phone,
      photo: photo,
      birthday: birthday,
      gender: gender,
      referredId: referredId,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(CreateStudentFailure(failure.errorMessage));
    }, (createStudent) {
      emit(CreateStudentSuccess(createStudent));
    },
    );
  }
}