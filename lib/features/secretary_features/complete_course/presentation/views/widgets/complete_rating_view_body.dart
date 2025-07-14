import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../course/presentation/manager/section_rating_cubit/section_rating_cubit.dart';
import '../../../../course/presentation/manager/section_rating_cubit/section_rating_state.dart';

class CompleteRatingViewBody extends StatelessWidget {
  const CompleteRatingViewBody({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionRatingCubit, SectionRatingState>(
        builder: (context, state) {
          if(state is SectionRatingSuccess) {
            return Padding(
              padding: EdgeInsets.only(top: 56.0.h,),
              child: CustomScreenBody(
                title: AppLocalizations.of(context).translate('Students'),
                onPressedFirst: () {},
                onPressedSecond: () {},
                body: Padding(
                  padding: EdgeInsets.only(top: 238.0.h,
                      left: 20.0.w,
                      right: 20.0.w,
                      bottom: 27.0.h),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        state.sectionRating.ratings!.isNotEmpty ? ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Align(child: RatingFieldItem(
                              color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                              image: state.sectionRating.ratings![index].student.photo,
                              name: state.sectionRating.ratings![index].student.name,
                              rating: state.sectionRating.ratings![index].rating,
                              dateText: state.sectionRating.ratings![index].createdAt.toString().replaceRange(10, 24, ''),
                              commentText: state.sectionRating.ratings![index].comment,
                              onTap: () {
                                //context.go('${GoRouterPath.studentDetails}/${state.showResult.students.data![index].id}');
                              },
                            ));
                          },
                          itemCount: state.sectionRating.ratings!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ) : CustomEmptyWidget(
                          firstText: AppLocalizations.of(context).translate('No students at this time'),
                          secondText: AppLocalizations.of(context).translate('Students will appear here after they enroll in your institute.'),
                        ),
                        CustomNumberPagination(
                          numberPages: 1 /*state.showResult.students.lastPage*/,
                          initialPage: 1 /*state.showResult.students.currentPage*/,
                          onPageChange: (int index) {
                            //context.read<StudentsCubit>().fetchStudents(page: index + 1);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if(state is SectionRatingFailure) {
            return CustomErrorWidget(errorMessage: state.errorMessage);
          } else {
            return CustomCircularProgressIndicator();
          }
        }
    );
  }
}