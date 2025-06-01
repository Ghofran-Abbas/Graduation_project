import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/password_reset_repo.dart';
import 'password_reset_state.dart';

class PasswordResetCubit extends Cubit<PasswordResetState>{
  static PasswordResetCubit get(context) => BlocProvider.of(context);

  PasswordResetCubit(this.passwordResetRepo) : super (PasswordResetInitial());

  final PasswordResetRepo passwordResetRepo;

  Future<void> fetchPasswordReset({
    required String token,
    required String password,
    required String password_confirmation,
  }) async {
    emit(PasswordResetLoading());
    var result = await passwordResetRepo.fetchPasswordReset(
      token: token,
      password: password,
      password_confirmation: password_confirmation,
    );

    result.fold((failure) {
      log(failure.errorMessage);
      emit(PasswordResetFailure(failure.errorMessage));
    }, (verificationSecretary) async {
      emit(PasswordResetSuccess(verificationSecretary));
    },
    );
  }
}