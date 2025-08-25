import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/notification_repo_impl.dart';
import '../manager/notifications_cubit/notifications_cubit.dart';
import 'widgets/notifications_view_body.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationsCubit(
          getIt.get<NotificationRepoImpl>(),
        )..fetchNotifications();
      },
      child: NotificationsViewBody(),
    );
  }
}
