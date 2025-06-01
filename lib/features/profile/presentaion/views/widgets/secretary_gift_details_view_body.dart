import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../manager/details_gift_cubit/details_gift_cubit.dart';
import '../../manager/details_gift_cubit/details_gift_state.dart';

class SecretaryGiftDetailsViewBody extends StatelessWidget {
  const SecretaryGiftDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsGiftCubit, DetailsGiftState>(
      builder: (context, state) {
        if(state is DetailsGiftSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 56.0.h,),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: CustomScreenBody(
                title: state.detailsGift.gift.secretary.name,
                onPressedFirst: () {},
                onPressedSecond: () {},
                body: Padding(
                  padding: EdgeInsets.only(top: 195.0.h,
                      left: 20.0.w,
                      right: 20.0.w,
                      bottom: 27.0.h),
                  child: CustomDetailsInformation(
                    imageWidth: 176.w,
                    imageHeight: 176.w,
                    image: state.detailsGift.gift.photo,
                    startDate: state.detailsGift.gift.date.toString().replaceRange(10, 24, ''),
                    showAboutText: true,
                    isAnnouncement: true,
                    hideSecondDate: true,
                    aboutText: state.detailsGift.gift.description,
                    onTap: () {},
                  ),
                ),
              ),
            ),
          );
        } else if(state is DetailsGiftFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
