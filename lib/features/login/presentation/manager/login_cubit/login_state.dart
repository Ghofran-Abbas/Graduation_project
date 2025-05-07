import 'package:alhadara_dashboard/features/login/data/models/login_secretary_model.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure(this.errorMessage);
}
class LoginSuccess extends LoginState {
  final LoginSecretaryModel loginResult;

  const LoginSuccess(this.loginResult);
}