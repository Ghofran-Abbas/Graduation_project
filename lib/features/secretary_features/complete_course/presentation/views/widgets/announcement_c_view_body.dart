import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';

class AnnouncementCViewBody extends StatelessWidget {
  const AnnouncementCViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'French',
        showSearchField: true,
        onPressedFirst: () {},
        onPressedSecond: () {},
        onTapSearch: () {},
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
                      text: 'Discount 30%'/*state.courses.courses.data![index].name*/,
                      onTap: () {
                        context.go('${GoRouterPath.completeDetails}/1${GoRouterPath.announcementsC}/1${GoRouterPath.announcementCDetails}/1');
                        //context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/1${GoRouterPath.announcementsA}/1${GoRouterPath.announcementADetails}/1');
                        //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.announcements}/1');
                      },
                      onTapFirstIcon: () {},
                      onTapSecondIcon: () {},
                    ));
                  },
                  itemCount: 7/*state.courses.courses.data!.length*/,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )/* : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('No thing to display')))*/,
                CustomNumberPagination(
                  numberPages: 1/*state.courses.courses.lastPage*/,
                  initialPage: 1/*state.courses.courses.currentPage*/,
                  onPageChange: (int index) {
                    //context.read<CoursesCubit>().fetchCourses(page: index + 1);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
