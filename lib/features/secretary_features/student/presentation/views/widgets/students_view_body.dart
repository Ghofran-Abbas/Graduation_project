import 'package:alhadara_dashboard/core/widgets/custom_icon_button.dart';
import 'package:alhadara_dashboard/core/widgets/custom_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/secretary/custom_dropdown_list.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/text_icon_button.dart';

class StudentsViewBody extends StatelessWidget {
  StudentsViewBody({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController specificationController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Students',
        showSearchField: true,
        textSecondButton: 'New student',
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
                    height: 858.h,
                    margin: EdgeInsets.symmetric(horizontal: 160.w, vertical: 85.h),
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
                              'Add student',
                              style: Styles.h3Bold(color: AppColors.t3),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 60.w),
                            child: Row(
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
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomLabelTextFormField(
                                        labelText: 'Full name',
                                        showLabelText: true,
                                        controller: nameController,
                                        topPadding: 20.h,
                                        bottomPadding: 0.h,
                                        leftPadding: 175.w,
                                        rightPadding: 127.w,
                                      ),
                                      CustomLabelTextFormField(
                                        labelText: 'Email address',
                                        showLabelText: true,
                                        controller: emailController,
                                        topPadding: 42.h,
                                        bottomPadding: 0.h,
                                        leftPadding: 175.w,
                                        rightPadding: 127.w,
                                      ),
                                      CustomLabelTextFormField(
                                        labelText: 'Password',
                                        showLabelText: true,
                                        controller: passwordController,
                                        topPadding: 42.h,
                                        bottomPadding: 0.h,
                                        leftPadding: 175.w,
                                        rightPadding: 127.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 60.w, right: 65.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: CustomLabelTextFormField(
                                              hintText: 'Birth date',
                                              readOnly: true,
                                              controller: birthDateController,
                                              topPadding: 68.h,
                                              leftPadding: 0.w,
                                              rightPadding: 0.w,
                                              bottomPadding: 0.h,
                                              onTap: () async {
                                                DateTime? pickedDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: birthDateController.text.isEmpty ? DateTime.now() : DateTime.parse(birthDateController.text),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                );
                                                if (pickedDate != null) {
                                                  birthDateController.text = pickedDate.toString().split(' ')[0];
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 19.w,),
                                          Expanded(
                                            child: CustomDropdownList(
                                              hintText: 'Gender',
                                              statusController: genderController,
                                              topPadding: 68.h,
                                              bottomPadding: 0.h,
                                              dropdownMenuEntries: [
                                                DropdownMenuEntry(
                                                  value: 'Female',
                                                  label: 'Female',
                                                ),
                                                DropdownMenuEntry(
                                                  value: 'Male',
                                                  label: 'Male',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: CustomLabelTextFormField(
                                  labelText: 'Phone number',
                                  showLabelText: true,
                                  controller: phoneController,
                                  topPadding: 42.h,
                                  bottomPadding: 0.h,
                                  leftPadding: 0.w,
                                  rightPadding: 128.w,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60.h, bottom: 65.h, left: 47.w, right: 155.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextIconButton(
                                  textButton: 'Add student',
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
                                    emailController.clear();
                                    phoneController.clear();
                                    birthDateController.clear();
                                    genderController.clear();
                                    passwordController.clear();
                                    specificationController.clear();
                                    aboutController.clear();
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
          padding: EdgeInsets.only(top: 238.0.h, left: 20.0.w, right: 20.0.w, bottom: 27.0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: CustomListInformationFields(
              secondField: 'Points',
              name: 'Jane Cooper',
              secondText: '150',
              thirdDetailsText: 'mickelle.rivera@exmple.com',
              fourthDetailsText: 'Female',
              itemCount: 20,
              showIcons: true,
              onTap: (){
                context.go('${GoRouterPath.studentDetails}/1');
              },
            ),
          ),
        ),
      ),
    );
  }
}
