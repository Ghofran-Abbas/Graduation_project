import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../course/presentation/manager/all_courses_cubit/all_courses_cubit.dart';
import '../../../../course/presentation/manager/all_courses_cubit/all_courses_state.dart';

class InPreparationViewBody extends StatelessWidget {
  const InPreparationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    return BlocBuilder<AllCoursesCubit, AllCoursesState>(
      builder: (context, state) {
        if(state is AllCoursesSuccess) {
          return Padding(
          padding: EdgeInsets.only(top: 56.0.h,),
          child: CustomScreenBody(
            title: AppLocalizations.of(context).translate('In Preparation'),
            showSearchField: true,
            onPressedFirst: (){},
            onPressedSecond: (){},
            onTapSearch: () {
              if(state.allCourses.courses.data!.isNotEmpty) {
                context.go(GoRouterPath.searchInPreparation);
              }
            },
            body: Padding(
              padding: EdgeInsets.only(top: 238.0.h, left: 47.0.w, right: 47.0.w, bottom: 27.0.h),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.allCourses.courses.data!.isNotEmpty ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                      itemBuilder: (BuildContext context, int index) {
                        return Align(child: CustomCard(
                          image: state.allCourses.courses.data![index].photo,
                          text: state.allCourses.courses.data![index].name,
                          onTap: () {
                            context.go('${GoRouterPath.inPreparationDetails}/${state.allCourses.courses.data![index].id}');
                            //context.go('${GoRouterPath.courses}/${stateD.showResult.department.id}${GoRouterPath.courseDetails}/${state.courses.courses.data![index].id}');
                          },
                          onTapFirstIcon: () {},
                          onTapSecondIcon: () {},
                        ));
                      },
                      itemCount: state.allCourses.courses.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ) : CustomEmptyWidget(
                      firstText: AppLocalizations.of(context).translate('No active courses at this time'),
                      secondText: AppLocalizations.of(context).translate('Courses will appear here after they enroll in your institute.'),
                    ),
                    CustomNumberPagination(
                      numberPages: state.allCourses.courses.lastPage,
                      initialPage: state.allCourses.courses.currentPage,
                      onPageChange: (int index) {
                        context.read<AllCoursesCubit>().fetchAllCourses(page: index + 1);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        } else if(state is AllCoursesFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
