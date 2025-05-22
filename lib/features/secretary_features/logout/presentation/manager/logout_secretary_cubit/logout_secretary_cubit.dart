import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/logout_secretary_repo.dart';
import 'logout_secretary_state.dart';

class LogoutSecretaryCubit extends Cubit<LogoutSecretaryState>{
  static LogoutSecretaryCubit get(context) => BlocProvider.of(context);

  LogoutSecretaryCubit(this.logoutSecretaryRepo) : super (LogoutSecretaryInitial());

  final LogoutSecretaryRepo logoutSecretaryRepo;

  Future<void> fetchLogoutSecretary() async {
    emit(LogoutSecretaryLoading());
    var result = await logoutSecretaryRepo.fetchLogoutSecretary();

    result.fold((failure) {
      log(failure.errorMessage);
      emit(LogoutSecretaryFailure(failure.errorMessage));
    }, (createTrainer) async {
      emit(LogoutSecretarySuccess(createTrainer));
    },
    );
  }
}