import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/notification_repo.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState>{
  static NotificationsCubit get(context) => BlocProvider.of(context);

  final NotificationRepo notificationRepo;

  NotificationsCubit(this.notificationRepo) : super(NotificationsInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());
    var result = await notificationRepo.fetchNotifications();

    result.fold((failure) {
      log(failure.errorMessage);
      emit(NotificationsFailure(failure.errorMessage));
    }, (notifications) {
      emit(NotificationsSuccess(notifications));
    });
  }
}