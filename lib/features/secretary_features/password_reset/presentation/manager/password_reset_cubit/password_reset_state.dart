import 'package:equatable/equatable.dart';

import '../../../data/models/password_reset_model.dart';


abstract class PasswordResetState extends Equatable {
  const PasswordResetState();

  @override
  List<Object> get props => [];
}

class PasswordResetInitial extends PasswordResetState {}
class PasswordResetLoading extends PasswordResetState {}
class PasswordResetFailure extends PasswordResetState {
  final String errorMessage;

  const PasswordResetFailure(this.errorMessage);
}
class PasswordResetSuccess extends PasswordResetState {
  final PasswordResetModel passwordResetResult;

  const PasswordResetSuccess(this.passwordResetResult);
}