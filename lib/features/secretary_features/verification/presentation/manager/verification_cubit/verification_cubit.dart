import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/verification_repo.dart';
import 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState>{
  static VerificationCubit get(context) => BlocProvider.of(context);

  VerificationCubit(this.verificationRepo) : super (VerificationInitial());

  final VerificationRepo verificationRepo;

  Future<void> fetchVerification({required String token,}) async {
    emit(VerificationLoading());
    var result = await verificationRepo.fetchVerification(token: token,);

    result.fold((failure) {
      log(failure.errorMessage);
      emit(VerificationFailure(failure.errorMessage));
    }, (verificationSecretary) async {
      emit(VerificationSuccess(verificationSecretary));
    },
    );
  }
}