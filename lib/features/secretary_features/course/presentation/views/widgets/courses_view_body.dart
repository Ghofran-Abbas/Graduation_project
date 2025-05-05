import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../../../core/widgets/text_icon_button.dart';

class CoursesViewBody extends StatelessWidget {
  CoursesViewBody({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Languages',
        showSearchField: true,
        textSecondButton: 'New course',
        showSecondButton: true,
        onPressedFirst: (){},
        onPressedSecond: (){
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return Align(
                alignment: Alignment.topRight,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 871.w,
                    height: 788.h,
                    margin: EdgeInsets.symmetric(horizontal: 160.w, vertical: 115.h),
                    padding:  EdgeInsets.all(22.r),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 65.h, left: 60.w, right: 155.w),
                            child: Text(
                              'Add course',
                              style: Styles.h3Bold(color: AppColors.t3),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 60.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          CustomImageAsset(
                                            imageWidth: 186.w,
                                            imageHeight: 186.w,
                                            borderRadius: 150.r,
                                          ),
                                          Positioned(
                                            top: 140.w,
                                            left: 150.w,
                                            child: CustomIconButton(
                                              icon: Icons.add,
                                              onTap: (){},
                                            ),
                                          ),
                                        ],
                                      ),
                                      CustomLabelTextFormField(
                                        labelText: 'Name',
                                        showLabelText: true,
                                        controller: nameController,
                                        topPadding: 68.h,
                                        bottomPadding: 0.h,
                                        leftPadding: 0.w,
                                        rightPadding: 65.w,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomLabelTextFormField(
                                        labelText: 'Description',
                                        showLabelText: true,
                                        controller: descriptionController,
                                        boxHeight: 360.h,
                                        maxLines: 11,
                                        topPadding: 35.h,
                                        bottomPadding: 0.h,
                                        leftPadding: 0.w,
                                        rightPadding: 128.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60.h, bottom: 65.h, left: 47.w, right: 155.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextIconButton(
                                  textButton: 'Add course',
                                  bigText: true,
                                  textColor: AppColors.t3,
                                  icon: Icons.add,
                                  iconSize: 40.01.r,
                                  iconColor: AppColors.t2,
                                  iconLast: false,
                                  firstSpaceBetween: 3.w,
                                  buttonHeight: 53.h,
                                  borderWidth: 0.w,
                                  buttonColor: AppColors.white,
                                  borderColor: Colors.transparent,
                                  onPressed: (){},
                                ),
                                SizedBox(width: 42.w,),
                                TextIconButton(
                                  textButton: '       Cancel       ',
                                  textColor: AppColors.t3,
                                  iconLast: false,
                                  buttonHeight: 53.h,
                                  borderWidth: 0.w,
                                  borderRadius: 4.r,
                                  buttonColor: AppColors.w1,
                                  borderColor: AppColors.w1,
                                  onPressed: (){
                                    nameController.clear();
                                    descriptionController.clear();
                                    Navigator.pop(dialogContext);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        body: Padding(
          padding: EdgeInsets.only(top: 238.0.h, left: 47.0.w, right: 47.0.w, bottom: 27.0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridViewCards(
                  text: 'Video Editing',
                  cardCount: 20,
                  showIcons: true,
                  onTap: (){context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}');},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
