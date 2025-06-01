import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';

class StudentArchiveCourseViewBody extends StatelessWidget {
  const StudentArchiveCourseViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Kristin\'s courses',
        onPressedFirst: () {},
        onPressedSecond: () {},
        onTapSearch: () {
          /*if(state.courses.courses.data!.isNotEmpty) {
            context.go('${GoRouterPath.courses}/${state.courses.courses.data![0].departmentId}${GoRouterPath.searchCourse}');
          }*/
        },
        body: Padding(
          padding: EdgeInsets.only(
              top: 238.0.h,
              left: 47.0.w,
              right: 47.0.w,
              bottom: 27.0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*state.courses.courses.data!.isNotEmpty ? */GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                  itemBuilder: (BuildContext context, int index) {
                    return Align(child: CustomCard(
                      image: ''/*state.courses.courses.data![index].photo*/,
                      text: 'English'/*state.courses.courses.data![index].name*/,
                      showDetailsText: true,
                      detailsText: 'Section1',
                      secondDetailsText: 'Languages',
                      showSecondDetailsText: true,
                      onTap: () {
                        context.go('${GoRouterPath.studentDetails}/1${GoRouterPath.studentArchiveCourseView}/1${GoRouterPath.archiveSectionStudentView}/1');
                        //context.go('${GoRouterPath.studentDetails}/${state.showResult.student.id}${GoRouterPath.studentArchiveCourseView}/${state.showResult.student.id}${GoRouterPath.archiveSectionCourseView}/1');
                      },
                      onTapFirstIcon: () {},
                      onTapSecondIcon: (){},
                    ));
                  },
                  itemCount: 7/*state.courses.courses.data!.length*/,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )/* : CustomEmptyWidget(
                  firstText: AppLocalizations.of(context).translate('No active courses at this time'),
                  secondText: AppLocalizations.of(context).translate('Courses will appear here after they enroll in your institute.'),
                )*/,
                /*CustomNumberPagination(
                  numberPages: state.courses.courses.lastPage,
                  initialPage: state.courses.courses.currentPage,
                  onPageChange: (int index) {
                    context.read<CoursesCubit>().fetchCourses(departmentId: state.courses.courses.data![index].departmentId, page: index + 1);
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
