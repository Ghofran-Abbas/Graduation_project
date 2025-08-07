import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../course/presentation/manager/search_course_cubit/search_course_cubit.dart';
import '../../../../course/presentation/manager/search_course_cubit/search_course_state.dart';

class SearchInPreparationViewBody extends StatelessWidget {
  SearchInPreparationViewBody({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCourseCubit, SearchCourseState>(
      builder: (context, state) {
        final screenWidth = MediaQuery.of(context).size.width;

        int crossAxisCount = ((screenWidth - 210) / 250).floor();
        crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
        return Padding(
          padding: EdgeInsets.only(top: 56.0.h,),
          child: CustomScreenBody(
            title: AppLocalizations.of(context).translate('Search'),
            turnSearch: true,
            searchController: searchController,
            onPressedFirst: () {},
            onPressedSecond: () {},
            onFieldSubmitted: (value) {
              context.read<SearchCourseCubit>().fetchSearchCourse(querySearch: searchController.text, page: 1);
            },
            body: Padding(
              padding: EdgeInsets.only(
                  top: 238.0.h,
                  left: 47.0.w,
                  right: 47.0.w,
                  bottom: 27.0.h),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: state is SearchCourseSuccess ? Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.course.courses.data!.isNotEmpty ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                      itemBuilder: (BuildContext context, int index) {
                        return Align(child: CustomCard(
                          image: state.course.courses.data![index].photo,
                          text: state.course.courses.data![index].name,
                          showIcons: true,
                          onTap: () {
                            context.go('${GoRouterPath.inPreparationDetails}/${state.course.courses.data![index].id}');
                          },
                          onTapFirstIcon: (){},
                          onTapSecondIcon: () {},
                        ));
                      },
                      itemCount: state.course.courses.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ) : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('No thing to display'))),
                    CustomNumberPagination(
                      numberPages: state.course.courses.lastPage,
                      initialPage: state.course.courses.currentPage,
                      onPageChange: (int index) {
                        context.read<SearchCourseCubit>().fetchSearchCourse(querySearch: searchController.text, page: index + 1);
                      },
                    ),
                  ],
                ) : state is SearchCourseFailure ? CustomErrorWidget(errorMessage: state.errorMessage)
                    : state is SearchCourseLoading ? CustomCircularProgressIndicator()
                    : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('Search to see more'))),
              ),
            ),
          ),
        );
      },
    );
  }
}
