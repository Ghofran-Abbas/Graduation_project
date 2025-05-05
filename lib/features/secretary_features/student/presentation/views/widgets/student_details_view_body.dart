import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_profile_cards.dart';
import '../../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/text_icon_button.dart';

class StudentDetailsViewBody extends StatelessWidget {
  StudentDetailsViewBody({super.key});

  final TextEditingController pointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Students',
        showSearchField: true,
        onPressedFirst: (){},
        onPressedSecond: (){},
        body: Padding(
          padding: EdgeInsets.only(top: 238.0.h, left: 20.0.w, right: 20.0.w, bottom: 27.0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomProfileInformation(
                  name: 'Kristin Watson',
                  firstBoxText: '+42 249 22 873',
                  firstBoxIcon: Icons.phone_in_talk_outlined,
                  secondBoxText: 'mickelle.rivera@exmple.com',
                  secondBoxIcon: Icons.mail_outlined,
                  firstFieldInfoText: '2002-07-05',
                  secondFieldInfoText: 'Female',
                  thirdFieldInfoText: '150',
                  showThirdFieldInfo: true,
                  showThirdFieldInfoIcon: true,
                  labelText: 'Students from the same class',
                  tailText: 'See more',
                  avatarCount: 1,
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return Align(
                          alignment: Alignment.topRight,
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              width: 638.w,
                              height: 478.h,
                              margin: EdgeInsets.symmetric(horizontal: 280.w, vertical: 255.h),
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
                                        'Edit points',
                                        style: Styles.h3Bold(color: AppColors.t3),
                                      ),
                                    ),
                                    CustomLabelTextFormField(
                                      labelText: 'Number',
                                      showLabelText: true,
                                      controller: pointController,
                                      topPadding: 60.h,
                                      bottomPadding: 0.h,
                                      rightPadding: 60.w,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 90.h, bottom: 65.h, left: 47.w, right: 155.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          TextIconButton(
                                            textButton: 'Add',
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
                                            textButton: '       Discount       ',
                                            textColor: AppColors.t3,
                                            iconLast: false,
                                            buttonHeight: 53.h,
                                            borderWidth: 0.w,
                                            borderRadius: 4.r,
                                            buttonColor: AppColors.w1,
                                            borderColor: AppColors.w1,
                                            onPressed: (){
                                              pointController.clear();
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
                ),
                CustomProfileCards(
                  labelText: 'Courses Kristin learns',
                  text: 'English',
                  showDetailsText: true,
                  detailsText: 'Section1',
                  secondDetailsText: 'Languages',
                  showSecondDetailsText: true,
                  cardCount: 5,
                  onTapCard: (){},
                  onTapSeeMore: (){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
