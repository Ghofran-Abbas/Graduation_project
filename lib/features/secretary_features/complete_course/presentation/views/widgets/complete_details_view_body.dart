import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_over_loading_card.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';

class CompleteDetailsViewBody extends StatelessWidget {
  const CompleteDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    int count = 10;
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
                      ratingText: '2.8',
                      ratingPercent: 1,
                      ratingPercentText: '100%',
                      circleStatusColor: AppColors.mintGreen,
                      courseStatusText: 'Complete',
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
                      onTap: (){},
                      onTapDate: (){
                        context.go('${GoRouterPath.completeDetails}/1${GoRouterPath.completeCalendar}');
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
                            context.go('${GoRouterPath.completeDetails}/1${GoRouterPath.completeStudents}/1');
                            //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${state.section.id}');
                          },
                        ),
                        SizedBox(width: calculateWidthBetweenAvatars(avatarCount: 5)/*270.w*/,),
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
                                    context.go('${GoRouterPath.completeDetails}/1${GoRouterPath.completeTrainers}/2');
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
                                    children: [
                                      GridViewFiles(
                                        fileName: 'hgjhv',
                                        cardCount: 5,
                                      ),
                                      NumberPaginator(
                                        numberPages: 1,
                                        onPageChange: (int index) {
                                        },
                                      ),
                                    ],
                                  ),
                                  CustomOverLoadingCard(
                                    cardCount: count,
                                    onTapSeeMore: () {
                                      context.go('${GoRouterPath.completeDetails}/1${GoRouterPath.announcementsC}/1');
                                      //context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/1${GoRouterPath.announcementsC}/1');
                                      //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.announcementsA}/1');
                                    },
                                    widget: GridView
                                        .builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: crossAxisCount,
                                          crossAxisSpacing: 10
                                              .w,
                                          mainAxisExtent: 354.66
                                              .h),
                                      itemBuilder: (
                                          BuildContext context,
                                          int index) {
                                        return Align(
                                            child: CustomCard(
                                              text: 'Discount 30%',
                                              onTap: () {
                                                context.go('${GoRouterPath.completeDetails}/1${GoRouterPath.announcementsC}/1${GoRouterPath.announcementCDetails}/1');
                                                //context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/1${GoRouterPath.announcementsC}/1${GoRouterPath.announcementCDetails}/1');
                                                //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.announcements}/1');
                                              },
                                              onTapFirstIcon: () {},
                                              onTapSecondIcon: () {},
                                            ));
                                      },
                                      itemCount: count >
                                          4
                                          ? 4
                                          : count,
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
}
