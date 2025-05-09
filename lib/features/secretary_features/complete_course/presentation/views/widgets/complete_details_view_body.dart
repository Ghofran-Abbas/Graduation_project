import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';

class CompleteDetailsViewBody extends StatelessWidget {
  const CompleteDetailsViewBody({super.key});

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
                    ),
                    SizedBox(height: 22.h),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomOverloadingAvatar(labelText: 'Look at 38 students in this class', tailText: 'See more', avatarCount: 5,),
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
