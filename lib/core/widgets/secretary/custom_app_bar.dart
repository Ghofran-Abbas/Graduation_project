import 'package:alhadara_dashboard/core/utils/go_router_path.dart';
import 'package:alhadara_dashboard/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../features/profile/presentaion/views/widgets/profile_view_body.dart';
import '../../localization/app_localizations.dart';
import '../../localization/local_cubit/local_cubit.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles.dart';
import '../custom_image_network.dart';
import '../custom_text_form_field.dart';
import '../custom_text_info.dart';
import '../text_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key, required this.title, this.showSearchField, this.textFirstButton, this.showFirstButton, this.showButtonIcon, this.textSecondButton, this.showSecondButton, required this.onPressedFirst, required this.onPressedSecond, this.widget, this.turnSearch, this.onFieldSubmitted, this.searchController, this.onTapSearch, this.showProfileAvatar,
  });

  final String title;
  final bool? showProfileAvatar;
  final bool? showSearchField;
  final String? textFirstButton;
  final bool? showFirstButton;
  final bool? showButtonIcon;
  final String? textSecondButton;
  final bool? showSecondButton;
  final bool? turnSearch;
  final Function onPressedFirst;
  final Function onPressedSecond;
  final Function? onTapSearch;
  final Function? onFieldSubmitted;
  final TextEditingController? searchController;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 50.0.w, right: 50.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Styles.h2Bold(color: AppColors.blue),
              ),
              showProfileAvatar ?? true ? BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoaded) {
                    if (state.user.photo != null) {
                      return CustomImageNetwork(
                      imageWidth: 44.w,
                      imageHeight: 44.w,
                      borderRadius: 50.67.r,
                      image: state.user.photo, // ✅ عرض الصورة هنا
                      onTap: () {
                        context.go(GoRouterPath.profile);
                      },
                    );
                    } else {
                      return GestureDetector(
                      child: CustomImageAsset(
                        imageWidth: 44.w,
                        imageHeight: 44.w,
                        borderRadius: 50.67.r,
                      ),
                      onTap: () {
                        context.go(GoRouterPath.profile);
                      },
                    );
                    }
                  } else {
                    return CustomCircularProgressIndicator(); // يمكن عرض صورة افتراضية أثناء التحميل
                  }
                },
              ) : SizedBox(width: 0.w, height: 0.h),
              /*GestureDetector(
                child: Icon(
                  Icons.translate_outlined,
                  color: AppColors.darkLightPurple,
                  size: 34.r,
                ),
                onTap: () {
                  final localeCubit = BlocProvider.of<LocaleCubit>(context);
                  if (localeCubit.state.languageCode == 'en') {
                    localeCubit.toArabic();
                  } else {
                    localeCubit.toEnglish();
                  }
                },
              ),*/
            ],
          ),
        ),
        SizedBox(height: 47.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showSearchField ?? false ? GestureDetector(
                onTap: () {onTapSearch!() ?? () {};},
                child: CustomTextInfo(
                  textAddress: AppLocalizations.of(context).translate('Search here...'),
                  text: '',
                  width: 199.96.w,
                  height: 53.h,
                  borderRadius: 24.67,
                  borderColor: Colors.transparent,
                  color: AppColors.highlightPurple,
                ),
              ) : SizedBox(width: 0.0,),
              turnSearch ?? false ? Flexible(
                child: SizedBox(
                  width: 1108.96.w,
                  height: 53.h,
                  child: CustomTextFormField(
                    hintText: AppLocalizations.of(context).translate('Search here...'),
                    hintTextStyle: Styles.l2Medium(color: AppColors.t1),
                    borderRadius: 4.r,
                    borderColor: Colors.transparent,
                    contentPadding: EdgeInsets.symmetric(horizontal: 19.73.w),
                    filled: true,
                    fillColor: AppColors.highlightPurple,
                    prefixIcon: Icons.search_outlined,
                    prefixSize: 19.73.r,
                    controller: searchController,
                    onTap: () {},
                    onPressed: () {},
                    onFieldSubmitted: (value) {onFieldSubmitted!(value) ?? (value) {};},
                  ),
                ),
              ) : SizedBox(width: 0.0,),
              Row(
                children: [
                  showFirstButton ?? false ? widget ?? TextIconButton(
                    textButton: textFirstButton ?? '',
                    textColor: AppColors.purple,
                    //buttonMinWidth: 125.36,
                    buttonHeight: 53.h,
                    icon: Icons.keyboard_arrow_down,
                    iconSize: 30.01.r,
                    iconColor: AppColors.purple,
                    borderRadius: 24.67,
                    buttonColor: AppColors.white,
                    iconLast: true,
                    showButtonIcon: showButtonIcon,
                    onPressed: (){
                      onPressedFirst();
                    },
                  ) : SizedBox(width: 0.0,),
                  SizedBox(width: 14.0.w,),
                  showSecondButton ?? false ? TextIconButton(
                    textButton: textSecondButton ?? '',
                    buttonHeight: 53.h,
                    icon: Icons.add,
                    iconSize: 30.01.r,
                    borderRadius: 24.67,
                    iconLast: false,
                    showButtonIcon: showButtonIcon,
                    onPressed: (){
                      onPressedSecond();
                    },
                  ) : SizedBox(width: 0.0,),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 171.h,),
      ],
    );
  }
}

/*
final localeCubit = BlocProvider.of<LocaleCubit>(context);
                  if (localeCubit.state.languageCode == 'en') {
                    localeCubit.toArabic();
                  } else {
                    localeCubit.toEnglish();
                  }
* */