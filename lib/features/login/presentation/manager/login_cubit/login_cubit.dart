import 'dart:developer';

import 'package:alhadara_dashboard/features/login/data/repos/login_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/shared_preferences_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginCubit(this.loginRepo) : super (LoginInitial());

  final LoginRepo loginRepo;

  Future<void> fetchCreateTrainer({
    required String email,
    required String password,
    required String fcm_token,
  }) async {
    emit(LoginLoading());
    var result = await loginRepo.fetchLoginSecretary(
      email: email,
      password: password,
      fcm_token: fcm_token,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(LoginFailure(failure.errorMessage));
    }, (createTrainer) async {
      await SharedPreferencesHelper.saveJwtToken(createTrainer.accessToken.accessToken);
      await SharedPreferencesHelper.saveUserID(createTrainer.accessToken.user.id);
      emit(LoginSuccess(createTrainer));
    },
    );
  }
}