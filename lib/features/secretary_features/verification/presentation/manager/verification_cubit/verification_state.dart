import 'package:equatable/equatable.dart';

import '../../../data/models/verification_model.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}
class VerificationLoading extends VerificationState {}
class VerificationFailure extends VerificationState {
  final String errorMessage;

  const VerificationFailure(this.errorMessage);
}
class VerificationSuccess extends VerificationState {
  final VerificationModel verificationResult;

  const VerificationSuccess(this.verificationResult);
}