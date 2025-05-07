import 'package:equatable/equatable.dart';

import '../../../data/models/forgot_password_model.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}
class ForgotPasswordLoading extends ForgotPasswordState {}
class ForgotPasswordFailure extends ForgotPasswordState {
  final String errorMessage;

  const ForgotPasswordFailure(this.errorMessage);
}
class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordModel forgotPasswordResult;

  const ForgotPasswordSuccess(this.forgotPasswordResult);
}