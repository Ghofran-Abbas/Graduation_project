import 'dart:developer';

import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:alhadara_dashboard/core/utils/assets.dart';
import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/secretary/custom_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/presentation/manager/CreateSectionCubit/CreateSectionCubit.dart';
import '../../../../course/presentation/manager/CreateSectionCubit/CreateSectionState.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';

class DetailsInPreparationViewBody extends StatelessWidget {
  DetailsInPreparationViewBody({super.key});

  final List<String> statusOptions = ['In preparation', 'Active now', 'Complete',];
  //int _currentPage = 0;
  final int _numPages = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Languages',
        showSearchField: true,
        textFirstButton: 'Section 2',
        showFirstButton: true,
        onPressedFirst: (){},
        onPressedSecond: (){},
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
                      ratingText: '0.0',
                      ratingPercent: 0,
                      ratingPercentText: '0%',
                      circleStatusColor: AppColors.mintGreen,
                      courseStatusText: 'In preparation',
                      showEditStatusIcon: true,
                      startDateText: '2025-09-02',
                      showCourseCalenderIcon: true,
                      endDateText: '2025-12-02',
                      numberSeatsText: '40 Seats',
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
                        context.go('${GoRouterPath.inPreparationDetails}/1${GoRouterPath.inPreparationCalendar}');
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
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //Image(image: AssetImage(Assets.empty)),
                                      Expanded(
                                        child: Text(
                                          'No courses at this time',
                                          style: Styles.h3Bold(color: AppColors.t3),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Courses will appear here after they enroll in your school.',
                                          style: Styles.l1Normal(color: AppColors.t3),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
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
}

/*
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(image: AssetImage(Assets.empty)),
                Expanded(
                  child: Text(
                    'No courses at this time',
                    style: Styles.h3Bold(color: AppColors.t3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Courses will appear here after they enroll in your school.',
                    style: Styles.l1Normal(color: AppColors.t3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
* */