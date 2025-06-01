import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../manager/search_student_cubit/search_student_cubit.dart';
import '../../manager/search_student_cubit/search_student_state.dart';

class SearchStudentViewBody extends StatelessWidget {
  SearchStudentViewBody({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchStudentCubit, SearchStudentState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 56.0.h,),
          child: CustomScreenBody(
            title: AppLocalizations.of(context).translate('Search'),
            turnSearch: true,
            searchController: searchController,
            onPressedFirst: () {},
            onPressedSecond: () {},
            onFieldSubmitted: (value) {
              context.read<SearchStudentCubit>().fetchSearchStudent(querySearch: searchController.text, page: 1);
            },
            body: Padding(
              padding: EdgeInsets.only(top: 238.0.h,
                  left: 20.0.w,
                  right: 20.0.w,
                  bottom: 27.0.h),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: state is SearchStudentSuccess ? Column(
                  children: [
                    state.student.students.data!.isNotEmpty ? CustomListInformationFields(
                      secondField: AppLocalizations.of(context).translate('Subject'),
                      showSecondField: true,
                      widget: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Align(child: InformationFieldItem(
                            color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                            image: state.student.students.data![index].photo,
                            name: state.student.students.data![index].name,
                            secondText: state.student.students.data![index].birthday.toString().replaceRange(10, 23, ''),
                            showSecondDetailsText: true,
                            thirdDetailsText: state.student.students.data![index].email,
                            fourthDetailsText: state.student.students.data![index].gender,
                            showIcons: true,
                            hideFirstIcon: true,
                            hideSecondIcon: true,
                            onTap: () {
                              context.go('${GoRouterPath.studentDetails}/${state.student.students.data![index].id}');
                            },
                            onTapFirstIcon: () {},
                            onTapSecondIcon: () {},
                          ));
                        },
                        itemCount: state.student.students.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ) : CustomEmptyWidget(
                      firstText: AppLocalizations.of(context).translate('No thing to display'),
                      secondText: '',
                    ),
                    CustomNumberPagination(
                      numberPages: state.student.students.lastPage,
                      initialPage: state.student.students.currentPage,
                      onPageChange: (int index) {
                        context.read<SearchStudentCubit>().fetchSearchStudent(querySearch: searchController.text, page: index + 1);
                      },
                    ),
                  ],
                ) : state is SearchStudentFailure ? CustomErrorWidget(errorMessage: state.errorMessage)
                    : state is SearchStudentLoading ? CustomCircularProgressIndicator()
                    : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('Search to see more'))),
              ),
            ),
          ),
        );
      },
    );
  }
}
