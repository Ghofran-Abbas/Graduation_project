import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/CustomTextFormField.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_dropdown_list.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_multiple_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_over_loading_card.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/CreateSectionCubit/CreateSectionCubit.dart';
import '../../manager/CreateSectionCubit/CreateSectionState.dart';

class CourseDetailsViewBody extends StatelessWidget {

  CourseDetailsViewBody({super.key});

  //int _currentPage = 0;
  final int _numPages = 10;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController sundayStartController = TextEditingController();
  final TextEditingController sundayEndController = TextEditingController();
  final TextEditingController mondayStartController = TextEditingController();
  final TextEditingController mondayEndController = TextEditingController();
  final TextEditingController tuesdayStartController = TextEditingController();
  final TextEditingController tuesdayEndController = TextEditingController();
  final TextEditingController wednesdayStartController = TextEditingController();
  final TextEditingController wednesdayEndController = TextEditingController();
  final TextEditingController thursdayStartController = TextEditingController();
  final TextEditingController thursdayEndController = TextEditingController();
  final TextEditingController fridayStartController = TextEditingController();
  final TextEditingController fridayEndController = TextEditingController();
  final TextEditingController saturdayStartController = TextEditingController();
  final TextEditingController saturdayEndController = TextEditingController();

  final List<String> dayOptions = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday',];
  final List<String> statusOptions = ['In preparation', 'Active now', 'Complete',];

  @override
  Widget build(BuildContext context) {
    List<String> selectedDays = [];
    String? startDate = DateTime.now().toString();
    return BlocConsumer<CreateSectionCubit, CreateSectionState>(
      listener: (context, state) {},
      builder: (context, state) {
        final screenWidth = MediaQuery.of(context).size.width;

        int crossAxisCount = ((screenWidth - 210) / 250).floor();
        crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
        int count = 10;
        return Padding(
          padding: EdgeInsets.only(top: 56.0.h,),
          child: CustomScreenBody(
            title: 'English',
            textFirstButton: 'Section 2',
            showFirstButton: true,
            onPressedFirst: (){
              CustomDropdownList(
                hintText: 'No section',
                statusController: statusController,
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: 'Section 1',
                    label: 'Section 1',
                  ),
                  DropdownMenuEntry(
                    value: 'Section 2',
                    label: 'Section 2',
                  ),
                  DropdownMenuEntry(
                    value: 'Section 2',
                    label: 'Section 2',
                  ),
                ],
              );
            },
            showButtonIcon: true,
            textSecondButton: 'New section',
            showSecondButton: true,
            onPressedSecond: (){
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return BlocProvider(
                    create: (_) => MultiCheckboxCubit(),
                    child: BlocBuilder<MultiCheckboxCubit, MultiCheckboxState>(
                      builder: (context, state) {
                        return Align(
                          alignment: Alignment.topRight,
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              width: 871.w,
                              height: 918.h,
                              margin: EdgeInsets.symmetric(horizontal: 160.w, vertical: 55.h),
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
                                        'Add Section',
                                        style: Styles.h3Bold(color: AppColors.t3),
                                      ),
                                    ),
                                    CustomLabelTextFormField(
                                      labelText: 'Name',
                                      showLabelText: true,
                                      controller: nameController,
                                      topPadding: 60.h,
                                      bottomPadding: 0.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 60.w, right: 155.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: CustomLabelTextFormField(
                                              labelText: 'Seats number',
                                              showLabelText: true,
                                              controller: seatsController,
                                              topPadding: 38.h,
                                              leftPadding: 0.w,
                                              rightPadding: 0.w,
                                              bottomPadding: 38.h,
                                            ),
                                          ),
                                          SizedBox(width: 19.w,),
                                          Expanded(
                                            flex: 1,
                                            child: CustomDropdownList(
                                              hintText: 'Status',
                                              statusController: statusController,
                                              dropdownMenuEntries: [
                                                DropdownMenuEntry(
                                                  value: 'In preparation',
                                                  label: 'In preparation',
                                                ),
                                                DropdownMenuEntry(
                                                  value: 'Active now',
                                                  label: 'Active now',
                                                ),
                                                DropdownMenuEntry(
                                                  value: 'Complete',
                                                  label: 'Complete',
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 19.w,),
                                          Expanded(
                                            flex: 1,
                                            child: CustomLabelTextFormField(
                                              hintText: 'Start date',
                                              readOnly: true,
                                              controller: startDateController,
                                              topPadding: 65.h,
                                              leftPadding: 0.w,
                                              rightPadding: 0.w,
                                              bottomPadding: 33.h,
                                              onTap: () async {
                                                DateTime? pickedDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: startDateController.text.isEmpty ? DateTime.now() : DateTime.parse(startDateController.text),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100),
                                                );
                                                if (pickedDate != null) {
                                                  startDateController.text = pickedDate.toString().split(' ')[0];
                                                  startDate = startDateController.text;
                                                  endDateController.clear();
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 19.w,),
                                          Expanded(
                                            flex: 1,
                                            child: CustomLabelTextFormField(
                                              hintText: 'End date',
                                              readOnly: true,
                                              controller: endDateController,
                                              topPadding: 65.h,
                                              leftPadding: 0.w,
                                              rightPadding: 0.w,
                                              bottomPadding: 38.h,
                                              onTap: () async {
                                                DateTime? pickedDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: endDateController.text.isEmpty ? DateTime.parse(startDate!) : DateTime.parse(endDateController.text),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2100),
                                                );
                                                if (pickedDate != null) {
                                                  endDateController.text = pickedDate.toString().split(' ')[0];
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 38.h, left: 60.w, right: 55.w),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 0.w, bottom: 4.h),
                                            child: Text(
                                              'Class days',
                                              style: Styles.l1Normal(color: AppColors.t2),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 728.w,
                                            child: Wrap(
                                              spacing: 12.w,
                                              runSpacing: 8,
                                              children: dayOptions.map((option) {
                                                final isSelected = state.selectedItems.contains(option);
                                                selectedDays = state.selectedItems;
                                                return CustomMultipleCheckBox(
                                                  isSelected: isSelected,
                                                  option: option,
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 60.w, right: 155.w),
                                      child: Wrap(
                                        children: [
                                          selectedDays.contains('Sunday') ? SizedBox(
                                            width: 187.w,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: 'Sunday',
                                                    showLabelText: true,
                                                    hintText: 'Start time',
                                                    readOnly: true,
                                                    controller: sundayStartController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 30.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      sundayStartController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 13.w,),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: '',
                                                    showLabelText: true,
                                                    hintText: 'End time',
                                                    readOnly: true,
                                                    controller: sundayEndController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 30.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      sundayEndController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) : SizedBox(width: 0.w, height: 0.h,),
                                          selectedDays.contains('Sunday') ? SizedBox(width: 13.w,) : SizedBox(width: 0.w, height: 0.h,),

                                          selectedDays.contains('Monday') ? SizedBox(
                                            width: 187.w,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: 'Monday',
                                                    showLabelText: true,
                                                    hintText: 'Start time',
                                                    readOnly: true,
                                                    controller: mondayStartController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 30.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      mondayStartController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 13.w,),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: '',
                                                    showLabelText: true,
                                                    hintText: 'End time',
                                                    readOnly: true,
                                                    controller: mondayEndController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 30.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      mondayEndController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) : SizedBox(width: 0.w, height: 0.h,),
                                          selectedDays.contains('Monday') ?SizedBox(width: 13.w,) : SizedBox(width: 0.w, height: 0.h,),

                                          selectedDays.contains('Tuesday') ? SizedBox(
                                            width: 187.w,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: 'Tuesday',
                                                    showLabelText: true,
                                                    hintText: 'Start time',
                                                    readOnly: true,
                                                    controller: tuesdayStartController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 30.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      tuesdayStartController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 13.w,),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: '',
                                                    showLabelText: true,
                                                    hintText: 'End time',
                                                    readOnly: true,
                                                    controller: tuesdayEndController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 30.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      tuesdayEndController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) : SizedBox(width: 0.w, height: 0.h,),
                                          selectedDays.contains('Tuesday') ?SizedBox(width: 13.w,) : SizedBox(width: 0.w, height: 0.h,),

                                          selectedDays.contains('Wednesday') ? SizedBox(
                                            width: 187.w,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: 'Wednesday',
                                                    showLabelText: true,
                                                    hintText: 'Start time',
                                                    readOnly: true,
                                                    controller: wednesdayStartController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 38.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      wednesdayStartController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 13.w,),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: '',
                                                    showLabelText: true,
                                                    hintText: 'End time',
                                                    readOnly: true,
                                                    controller: wednesdayEndController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 38.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      wednesdayEndController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) : SizedBox(width: 0.w, height: 0.h,),
                                          selectedDays.contains('Wednesday') ?SizedBox(width: 13.w,) : SizedBox(width: 0.w, height: 0.h,),

                                          selectedDays.contains('Thursday') ? SizedBox(
                                            width: 187.w,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: 'Thursday',
                                                    showLabelText: true,
                                                    hintText: 'Start time',
                                                    readOnly: true,
                                                    controller: thursdayStartController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 38.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      thursdayStartController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 13.w,),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: '',
                                                    showLabelText: true,
                                                    hintText: 'End time',
                                                    readOnly: true,
                                                    controller: thursdayEndController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 38.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      thursdayEndController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) : SizedBox(width: 0.w, height: 0.h,),
                                          selectedDays.contains('Thursday') ?SizedBox(width: 13.w,) : SizedBox(width: 0.w, height: 0.h,),

                                          selectedDays.contains('Friday') ? SizedBox(
                                            width: 187.w,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: 'Friday',
                                                    showLabelText: true,
                                                    hintText: 'Start time',
                                                    readOnly: true,
                                                    controller: fridayStartController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 38.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      fridayStartController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 13.w,),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: '',
                                                    showLabelText: true,
                                                    hintText: 'End time',
                                                    readOnly: true,
                                                    controller: fridayEndController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 38.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      fridayEndController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) : SizedBox(width: 0.w, height: 0.h,),
                                          selectedDays.contains('Friday') ?SizedBox(width: 13.w,) : SizedBox(width: 0.w, height: 0.h,),

                                          selectedDays.contains('Saturday') ? SizedBox(
                                            width: 187.w,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: 'Saturday',
                                                    showLabelText: true,
                                                    hintText: 'Start time',
                                                    readOnly: true,
                                                    controller: saturdayStartController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 38.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      saturdayStartController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 13.w,),
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomLabelTextFormField(
                                                    labelText: '',
                                                    showLabelText: true,
                                                    hintText: 'End time',
                                                    readOnly: true,
                                                    controller: saturdayEndController,
                                                    topPadding: 0.h,
                                                    leftPadding: 0.w,
                                                    rightPadding: 0.w,
                                                    bottomPadding: 38.h,
                                                    onTap: () async {
                                                      TimeOfDay? time = await showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now(),
                                                      );
                                                      saturdayEndController.text = '${time!.hour}:${time.minute}';
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ) : SizedBox(width: 0.w, height: 0.h,),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 22.h, bottom: 65.h, left: 47.w, right: 155.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          TextIconButton(
                                            textButton: 'Add section',
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
                                              seatsController.clear();
                                              statusController.clear();
                                              startDateController.clear();
                                              endDateController.clear();
                                              Navigator.pop(context);
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
                    ),
                  );
                },
              );
            },
            body: Padding(
              padding: EdgeInsets.only(top: 238.0.h, left: 77.0.w, bottom: 27.0.h),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CustomCourseInformation(
                          ratingText: '4.9',
                          ratingPercent: 0.5,
                          ratingPercentText: '50%',
                          circleStatusColor: AppColors.mintGreen,
                          courseStatusText: 'Active now',
                          showEditStatusIcon: true,
                          startDateText: '2025-12-07',
                          showCourseCalenderIcon: true,
                          endDateText: '2025-12-02',
                          numberSeatsText: '35 Seats',
                          bodyText: 'Nulla Lorem mollit cupidatat irure. Laborum\n'
                              'magna nulla duis ullamco cillum dolor.\n'
                              'Voluptate exercitation incididunt aliquip\n'
                              'deserunt reprehenderit elit laborum. Nulla\n'
                              'Lorem mollit cupidatat irure. Laborum\n'
                              'magna nulla duis ullamco cillum dolor.\n'
                              'Voluptate exercitation incididunt aliquip\n'
                              'deserunt reprehenderit elit laborum. ',
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return BlocProvider(
                                  create: (_) => SingleCheckboxCubit(),
                                  child: BlocBuilder<SingleCheckboxCubit, SingleCheckboxState>(
                                    builder: (context, state) {
                                      String? selected = '';
                                      if (state is SingleCheckboxUpdated) {
                                        selected = state.selectedItem;
                                      }
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
                                                      'Edit status',
                                                      style: Styles.h3Bold(color: AppColors.t3),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 42.h, bottom: 68.h, left: 60.w, right: 55.w),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 0.w, bottom: 22.h),
                                                          child: Text(
                                                            '',
                                                            style: Styles.l1Normal(color: AppColors.t2),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 728.w,
                                                          child: Wrap(
                                                            spacing: 70.w,
                                                            runSpacing: 8,
                                                            children: statusOptions.map((option) {
                                                              final isSelected = selected == option;
                                                              return CustomCheckBox(
                                                                isSelected: isSelected,
                                                                option: option,
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 22.h, bottom: 65.h, left: 47.w, right: 155.w),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        TextIconButton(
                                                          textButton: 'Edit status',
                                                          bigText: true,
                                                          textColor: AppColors.t3,
                                                          icon: Icons.edit,
                                                          iconSize: 40.01.r,
                                                          iconColor: AppColors.t2,
                                                          iconLast: false,
                                                          firstSpaceBetween: 3.w,
                                                          buttonHeight: 53.h,
                                                          borderWidth: 0.w,
                                                          buttonColor: AppColors.white,
                                                          borderColor: Colors.transparent,
                                                          onPressed: (){
                                                            log(selected!);
                                                          },
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
                                                            startDateController.clear();
                                                            endDateController.clear();
                                                            Navigator.pop(context);
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
                                  ),
                                );
                              },
                            );
                          },
                          onTapDate: (){
                            context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}${GoRouterPath.calendar}');
                          },
                        ),
                        SizedBox(height: 22.h),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CustomOverloadingAvatar(labelText: 'Look at 17 students in this class', tailText: 'See more', avatarCount: 5,),
                            SizedBox(width: calculateWidthBetweenAvatars(avatarCount: 5)/*270.w*/,),
                            CustomOverloadingAvatar(labelText: 'Look at trainers in this class', tailText: 'See more', avatarCount: 2,),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.h, right: 47.0.w,),
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 70.h,
                                  child: TabBar(
                                    labelColor: AppColors.blue,
                                    unselectedLabelColor: AppColors.blue,
                                    indicator: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.darkBlue,
                                    ),
                                    indicatorPadding: EdgeInsets.only(top: 48.r, bottom: 12.r),
                                    indicatorWeight: 20,
                                    labelStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                                    tabs: [
                                      Tab(text: '         File         ',),
                                      Tab(text: 'Announcement'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 470.23.h,
                                  child: TabBarView(
                                    children: [
                                      Column(
                                        children: [
                                          GridViewFiles(
                                            fileName: 'hgjhv',
                                            cardCount: 5,
                                          ),
                                          NumberPaginator(
                                            numberPages: _numPages,
                                            onPageChange: (int index) {
                                            },
                                          ),
                                        ],
                                      ),
                                      CustomOverLoadingCard(
                                        cardCount: count,
                                        onTapSeeMore: (){},
                                        widget: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                                          itemBuilder: (BuildContext context, int index) {
                                            return Align(child: CustomCard(
                                              text: 'Discount 30%',
                                              showIcons: true,
                                              onTap: (){/*context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}');*/},
                                            ));
                                          },
                                          itemCount: count > 4 ? 4 : count,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

double calculateWidthBetweenAvatars({
  required int avatarCount
})
{
  double width = 8.6;
  if(avatarCount >= 1) {
    width = 496.w;
  }
  if(avatarCount >= 2) {
    width = 442.w;
  }
  if(avatarCount >= 3) {
    width = 386.w;
  }
  if(avatarCount >= 4) {
    width = 328.w;
  }
  if(avatarCount >= 5) {
    width = 270.w;
  }
  return width;
}