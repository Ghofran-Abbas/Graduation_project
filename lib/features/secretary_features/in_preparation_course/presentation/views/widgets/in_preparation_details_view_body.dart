import 'dart:developer';

import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:alhadara_dashboard/core/utils/assets.dart';
import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/secretary/custom_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/presentation/manager/create_section_cubit/create_section_cubit.dart';
import '../../../../course/presentation/manager/create_section_cubit/create_section_state.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';

class DetailsInPreparationViewBody extends StatelessWidget {
  DetailsInPreparationViewBody({super.key});

  final List<String> statusOptions = ['In preparation', 'Active now', 'Complete',];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Video Editing',
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
                      showSectionInformation: true,
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
                                                  AppLocalizations.of(context).translate('Edit status'),
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
                                                      textButton: AppLocalizations.of(context).translate('Edit status'),
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
                                                      textButton: AppLocalizations.of(context).translate('       Cancel       '),
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
                      onTapFirstIcon: (){},
                      onTapSecondIcon: (){},
                    ),
                    SizedBox(height: 22.h),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomOverloadingAvatar(
                          labelText: '${AppLocalizations.of(context).translate('Look at')} 17 ${AppLocalizations.of(context).translate('students in this class')}',
                          tailText: AppLocalizations.of(context).translate('See more'),
                          firstImage: '',
                          secondImage: '',
                          thirdImage: '',
                          fourthImage: '',
                          fifthImage: '',
                          avatarCount: 5,
                          onTap: (){
                            context.go('${GoRouterPath.inPreparationDetails}/1${GoRouterPath.inPreparationStudents}/1');
                            //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${state.section.id}');
                          },
                        ),
                        SizedBox(width: calculateWidthBetweenAvatars(avatarCount: 5),),
                        BlocBuilder<TrainersSectionCubit, TrainersSectionState>(
                            builder: (contextTS, stateTS) {
                              if(stateTS is TrainersSectionSuccess) {
                                return CustomOverloadingAvatar(
                                  labelText: '${AppLocalizations.of(context).translate('Look at')} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                  tailText: AppLocalizations.of(context).translate('See more'),
                                  firstImage: stateTS.trainers.trainers![0].trainers!.isNotEmpty ? stateTS.trainers.trainers![0].trainers![0].photo : '',
                                  secondImage: stateTS.trainers.trainers![0].trainers!.length >= 2 ? stateTS.trainers.trainers![0].trainers![1].photo : '',
                                  thirdImage: stateTS.trainers.trainers![0].trainers!.length >= 3 ? stateTS.trainers.trainers![0].trainers![2].photo : '',
                                  fourthImage: stateTS.trainers.trainers![0].trainers!.length >= 4 ? stateTS.trainers.trainers![0].trainers![3].photo : '',
                                  fifthImage: stateTS.trainers.trainers![0].trainers!.length >= 5 ? stateTS.trainers.trainers![0].trainers![4].photo : '',
                                  avatarCount: stateTS.trainers.trainers![0].trainers!.length,
                                  onTap: () {
                                    context.go('${GoRouterPath.inPreparationDetails}/1${GoRouterPath.inPreparationTrainers}/1');
                                    //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionTrainers}/${state.section.id}');
                                  },
                                );
                              } else if(stateTS is TrainersSectionFailure) {
                                return CustomErrorWidget(
                                    errorMessage: stateTS.errorMessage);
                              } else {
                                return CustomCircularProgressIndicator();
                              }
                            }
                        ),
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
                                  Tab(text: AppLocalizations.of(context).translate('         File         '),),
                                  Tab(text: AppLocalizations.of(context).translate('Announcement')),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 470.23.h,
                              child: TabBarView(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //Image(image: AssetImage(Assets.empty)),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate('No courses at this time'),
                                          style: Styles.h3Bold(color: AppColors.t3),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate('Courses will appear here after they enroll in your school.'),
                                          style: Styles.l1Normal(color: AppColors.t3),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                                          AppLocalizations.of(context).translate('No courses at this time'),
                                          style: Styles.h3Bold(color: AppColors.t3),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context).translate('Courses will appear here after they enroll in your school.'),
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
