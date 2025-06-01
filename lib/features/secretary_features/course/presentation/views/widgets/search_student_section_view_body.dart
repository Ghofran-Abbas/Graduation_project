import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/add_section_student_cubit/add_section_student_state.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/search_student_cubit/search_student_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/search_student_cubit/search_student_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/add_section_student_cubit/add_section_student_cubit.dart';

class SearchStudentSectionViewBody extends StatelessWidget {
  SearchStudentSectionViewBody({super.key, required this.sectionId});

  final int sectionId;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchStudentCubit, SearchStudentState>(
      builder: (context, state) {
        return BlocConsumer<AddSectionStudentCubit, AddSectionStudentState>(
            listener: (contextA, stateA) {
              if (stateA is AddSectionStudentFailure) {
                CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('AddSectionStudentFailure'),);
              } else if (stateA is AddSectionStudentSuccess) {
                CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('AddSectionStudentSuccess'),);
                Navigator.pop(context);
              }
            },
            builder: (contextA, stateA) {
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
                          CustomListInformationFields(
                            secondField: AppLocalizations.of(context).translate('Subject'),
                            showSecondField: true,
                            widget: state.student.students.data!.isNotEmpty ?ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return Align(child: InformationFieldItem(
                                  color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                  image: state.student.students.data![index].photo,
                                  name: state.student.students.data![index].name,
                                  secondText: state.student.students.data![index].birthday.toString().replaceRange(10, 23, ''),
                                  showSecondDetailsText: true,
                                  thirdDetailsText: state.student.students.data![index].email,
                                  fourthDetailsText: state.student.students.data![index].gender,
                                  showFirstBox: true,
                                  showIcons: true,
                                  hideFirstIcon: true,
                                  hideSecondIcon: true,
                                  onTap: () {
                                    context.go('${GoRouterPath.studentDetails}/${state.student.students.data![index].id}');
                                  },
                                  onTapFirstIcon: () {},
                                  onTapSecondIcon: () {},
                                  onTapFirstBox: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
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
                                                      padding: EdgeInsets.only(top: 65.h, left: 30.w, right: 155.w),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.error_outline,
                                                            color: AppColors.orange,
                                                            size: 55.r,
                                                          ),
                                                          SizedBox(width: 10.w,),
                                                          Text(
                                                            AppLocalizations.of(context).translate('Warning'),
                                                            style: Styles.h3Bold(color: AppColors.t3),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 75.h, left: 65.w, right: 155.w),
                                                      child: Text(
                                                        AppLocalizations.of(context).translate('Are you sure you want to add this student to section?'),
                                                        style: Styles.b2Normal(color: AppColors.t3),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 90.h, bottom: 65.h, left: 47.w, right: 155.w),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          TextIconButton(
                                                            textButton: AppLocalizations.of(context).translate('Confirm'),
                                                            bigText: true,
                                                            textColor: AppColors.t3,
                                                            icon: Icons.check_circle_outline,
                                                            iconSize: 40.01.r,
                                                            iconColor: AppColors.t2,
                                                            iconLast: false,
                                                            firstSpaceBetween: 3.w,
                                                            buttonHeight: 53.h,
                                                            borderWidth: 0.w,
                                                            buttonColor: AppColors.white,
                                                            borderColor: Colors.transparent,
                                                            onPressed: (){
                                                              contextA.read<AddSectionStudentCubit>().fetchAddSectionStudent(sectionId: sectionId, studentId: state.student.students.data![index].id);
                                                              Navigator.pop(dialogContext);
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
                                                              Navigator.pop(dialogContext);
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
                                    );
                                  },
                                ));
                              },
                              itemCount: state.student.students.data!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ) : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('No thing to display'))),
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
            }
        );
      },
    );
  }
}
