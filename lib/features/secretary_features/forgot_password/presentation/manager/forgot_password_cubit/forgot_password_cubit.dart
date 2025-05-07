import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/forgot_password_repo.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState>{
  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  ForgotPasswordCubit(this.forgotPasswordRepo) : super (ForgotPasswordInitial());

  final ForgotPasswordRepo forgotPasswordRepo;

  Future<void> fetchForgotPassword({
    required String email,
  }) async {
    emit(ForgotPasswordLoading());
    var result = await forgotPasswordRepo.fetchForgotPassword(
      email: email,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(ForgotPasswordFailure(failure.errorMessage));
    }, (forgotPasswordSecretary) async {
      emit(ForgotPasswordSuccess(forgotPasswordSecretary));
    },
    );
  }
}