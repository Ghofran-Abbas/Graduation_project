import 'package:equatable/equatable.dart';

import '../../../data/models/notifications_model.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}
class NotificationsLoading extends NotificationsState {}
class NotificationsFailure extends NotificationsState {
  final String errorMessage;

  const NotificationsFailure(this.errorMessage);
}
class NotificationsSuccess extends NotificationsState {
  final NotificationsModel notifications;

  const NotificationsSuccess(this.notifications);
}