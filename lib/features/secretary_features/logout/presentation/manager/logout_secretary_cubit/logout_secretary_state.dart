import 'package:equatable/equatable.dart';

import '../../../data/models/logout_secretary_model.dart';

abstract class LogoutSecretaryState extends Equatable {
  const LogoutSecretaryState();

  @override
  List<Object> get props => [];
}

class LogoutSecretaryInitial extends LogoutSecretaryState {}
class LogoutSecretaryLoading extends LogoutSecretaryState {}
class LogoutSecretaryFailure extends LogoutSecretaryState {
  final String errorMessage;

  const LogoutSecretaryFailure(this.errorMessage);
}
class LogoutSecretarySuccess extends LogoutSecretaryState {
  final LogoutSecretaryModel logoutSecretaryResult;

  const LogoutSecretarySuccess(this.logoutSecretaryResult);
}