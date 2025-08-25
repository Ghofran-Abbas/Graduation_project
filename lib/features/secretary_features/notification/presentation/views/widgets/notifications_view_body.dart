import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../manager/notifications_cubit/notifications_cubit.dart';
import '../../manager/notifications_cubit/notifications_state.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if(state is NotificationsSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 56.0.h,),
            child: CustomScreenBody(
              title: AppLocalizations.of(context).translate('Notifications'),
              onPressedFirst: () {},
              onPressedSecond: () {},
              body: Padding(
                padding: EdgeInsets.only(top: 158.0.h, left: 20.0.w, right: 20.0.w, bottom: 27.0.h),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 41.w,
                                  height: 41.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80.r),
                                      color: AppColors.lightPurple1
                                  ),
                                  child: Icon(
                                    Icons.notifications,
                                    color: AppColors.purple,
                                    size: 32.r,
                                  ),
                                ),
                                Positioned(
                                  bottom: 31.w,
                                  left: 31.w,
                                  child: CustomIconButton(
                                    radius: 4.6,
                                    size: 0,
                                    icon: Icons.check,
                                    color: AppColors.mintGreen,
                                    backgroundColor: state.notifications.notifications![index].isRead == 0 ? AppColors.red : AppColors.mintGreen,
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 11.w,),
                            SizedBox(
                              height: 120.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.notifications.notifications![index].title,
                                      style: Styles.b2Bold(color: AppColors.t4),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.notifications.notifications![index].body,
                                      style: Styles.l1Normal(color: AppColors.t4),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.notifications.notifications![index].createdAt.toString().replaceRange(16, 24, ''),
                                      style: Styles.l2Medium(color: AppColors.t2),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: state.notifications.notifications!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
            ),
          );
        } else if(state is NotificationsFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
