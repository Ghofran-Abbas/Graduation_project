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
import '../../manager/archive_section_student_cubit/archive_section_student_cubit.dart';
import '../../manager/archive_section_student_cubit/archive_section_student_state.dart';

class StudentArchiveCourseViewBody extends StatelessWidget {
  const StudentArchiveCourseViewBody({super.key, required this.studentId});

  final int studentId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: AppLocalizations.of(context).translate('Courses'),
        onPressedFirst: () {},
        onPressedSecond: () {},
        onTapSearch: () {
          /*if(state.courses.courses.data!.isNotEmpty) {
            context.go('${GoRouterPath.courses}/${state.courses.courses.data![0].departmentId}${GoRouterPath.searchCourse}');
          }*/
        },
        body: BlocBuilder<ArchiveStudentCubit, ArchiveStudentState>(
          builder: (context, state) {
            if(state is ArchiveStudentSuccess) {
              return Padding(
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
                      state.showResult.courses.data!.isNotEmpty ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                        itemBuilder: (BuildContext context, int index) {
                          return Align(child: CustomCard(
                            image: state.showResult.courses.data![index].course.photo,
                            text: state.showResult.courses.data![index].course.name,
                            showDate: true,
                            dateText: state.showResult.courses.data![index].name,
                            //secondDetailsText: 'Languages',
                            //showSecondDetailsText: false,
                            onTap: () {
                              context.go('${GoRouterPath.studentDetails}/$studentId${GoRouterPath.studentArchiveCourseView}/$studentId${GoRouterPath.archiveSectionStudentView}/${state.showResult.courses.data![index].id}/${state.showResult.courses.data![index].course.id}/$studentId');
                              //context.go('${GoRouterPath.studentDetails}/${state.showResult.student.id}${GoRouterPath.studentArchiveCourseView}/${state.showResult.student.id}${GoRouterPath.archiveSectionCourseView}/1');
                            },
                            onTapFirstIcon: () {},
                            onTapSecondIcon: (){},
                          ));
                        },
                        itemCount: state.showResult.courses.data!.length/*state.courses.courses.data!.length*/,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ) : CustomEmptyWidget(
                        firstText: AppLocalizations.of(context).translate('No active courses at this time'),
                        secondText: AppLocalizations.of(context).translate('Courses will appear here after they enroll in your institute.'),
                      ),
                      CustomNumberPagination(
                        numberPages: state.showResult.courses.lastPage,
                        initialPage: state.showResult.courses.currentPage,
                        onPageChange: (int index) {
                          context.read<ArchiveStudentCubit>().fetchArchiveStudent(id: studentId, page: index + 1);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if(state is ArchiveStudentFailure) {
              return CustomErrorWidget(errorMessage: state.errorMessage);
            } else {
              return CustomCircularProgressIndicator();
            }
          }
        ),
      ),
    );
  }
}
