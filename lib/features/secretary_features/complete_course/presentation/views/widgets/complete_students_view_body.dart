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
import '../../../../../../core/widgets/secretary/custom_top_information_field.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../course/presentation/manager/confirmed_students_section_cubit/confirmed_students_section_cubit.dart';
import '../../../../course/presentation/manager/confirmed_students_section_cubit/confirmed_students_section_state.dart';
import '../../../../course/presentation/manager/reservation_students_section_cubit/reservation_students_section_cubit.dart';
import '../../../../course/presentation/manager/reservation_students_section_cubit/reservation_students_section_state.dart';

class CompleteStudentsViewBody extends StatelessWidget {
  const CompleteStudentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmedStudentsSectionCubit, ConfirmedStudentsSectionState>(
      builder: (contextCS, stateCS) {
        if(stateCS is ConfirmedStudentsSectionSuccess) {
          return BlocBuilder<ReservationStudentsSectionCubit, ReservationStudentsSectionState>(
              builder: (contextRS, stateRS) {
                if(stateRS is ReservationStudentsSectionSuccess) {
                  return Padding(
                    padding: EdgeInsets.only(top: 56.0.h,),
                    child: CustomScreenBody(
                      title: 'Students',
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
                              CustomTopInformationField(
                                firstText: '${stateCS.confirmedStudents.students.data![0].students!.length} Seats',
                                secondText: '${stateRS.reservationStudents.reservations.data![0].students!.length} Seats',
                                thirdText: '${stateCS.confirmedStudents.students.data![0].seatsOfNumber - (stateCS.confirmedStudents.students.data![0].students!.length + stateRS.reservationStudents.reservations.data![0].students!.length)} Seats',
                              ),
                              SizedBox(height: 40.h,),
                              CustomListInformationFields(
                                secondField: AppLocalizations.of(context).translate('Birth date'),
                                showSecondField: true,
                                showFifthField: true,
                                widget: (stateCS.confirmedStudents.students.data![0].students!.isNotEmpty || stateRS.reservationStudents.reservations.data![0].students!.isNotEmpty) ? Column(
                                  children: [
                                    stateCS.confirmedStudents.students.data![0].students!.isNotEmpty ? ListView.builder(
                                      itemBuilder: (BuildContext context, int index) {
                                        return Align(child: InformationFieldItem(
                                          color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                          image: stateCS.confirmedStudents.students.data![0].students![index].photo,
                                          name: stateCS.confirmedStudents.students.data![0].students![index].name,
                                          secondText: stateCS.confirmedStudents.students.data![0].students![index].birthday.toString().replaceRange(10, 23, ''),
                                          showSecondDetailsText: true,
                                          thirdDetailsText: stateCS.confirmedStudents.students.data![0].students![index].email,
                                          fourthDetailsText: stateCS.confirmedStudents.students.data![0].students![index].gender,
                                          fifthText: 'Confirmed',
                                          showFifthDetailsText: true,
                                          fifthTextColor: AppColors.mintGreen,
                                          onTap: () {
                                            context.go('${GoRouterPath.studentDetails}/${stateCS.confirmedStudents.students.data![0].students![index].id}');
                                          },
                                          onTapFirstIcon: () {},
                                          onTapSecondIcon: () {},
                                        ));
                                      },
                                      itemCount: stateCS.confirmedStudents.students.data![0].students!.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ) : SizedBox(width: 0.w, height: 0.h,),
                                    stateRS.reservationStudents.reservations.data![0].students!.isNotEmpty ? ListView.builder(
                                      itemBuilder: (BuildContext context, int index) {
                                        return Align(child: InformationFieldItem(
                                          color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                          image: stateRS.reservationStudents.reservations.data![0].students![index].photo,
                                          name: stateRS.reservationStudents.reservations.data![0].students![index].name,
                                          secondText: stateRS.reservationStudents.reservations.data![0].students![index].birthday.toString().replaceRange(10, 23, ''),
                                          showSecondDetailsText: true,
                                          thirdDetailsText: stateRS.reservationStudents.reservations.data![0].students![index].email,
                                          fourthDetailsText: stateRS.reservationStudents.reservations.data![0].students![index].gender,
                                          fifthText: 'Pending',
                                          showFifthDetailsText: true,
                                          fifthTextColor: AppColors.t1,
                                          onTap: () {
                                            context.go('${GoRouterPath.studentDetails}/${stateRS.reservationStudents.reservations.data![0].students![index].id}');
                                          },
                                          onTapFirstIcon: () {},
                                          onTapSecondIcon: () {},
                                        ));
                                      },
                                      itemCount: stateRS.reservationStudents.reservations.data![0].students!.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ) : SizedBox(width: 0.w, height: 0.h,),
                                    CustomNumberPagination(
                                      numberPages: stateCS.confirmedStudents.students.lastPage > stateRS.reservationStudents.reservations.lastPage ? stateCS.confirmedStudents.students.lastPage : stateRS.reservationStudents.reservations.lastPage,
                                      initialPage: stateCS.confirmedStudents.students.lastPage > stateRS.reservationStudents.reservations.lastPage ? stateCS.confirmedStudents.students.currentPage : stateRS.reservationStudents.reservations.currentPage,
                                      onPageChange: (int index) {
                                        context.read<ConfirmedStudentsSectionCubit>().fetchConfirmedStudentsSection(id: stateCS.confirmedStudents.students.data![0].id, page: index + 1);
                                        context.read<ReservationStudentsSectionCubit>().fetchReservationStudentsSection(id: stateRS.reservationStudents.reservations.data![0].id, page: index + 1);
                                      },
                                    )
                                  ],
                                ) : CustomEmptyWidget(
                                  firstText: AppLocalizations.of(context).translate('No students in this section at this time'),
                                  secondText: AppLocalizations.of(context).translate('Students will appear here after they enroll in your institute.'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if(stateRS is ReservationStudentsSectionFailure) {
                  return CustomErrorWidget(errorMessage: stateRS.errorMessage);
                } else {
                  return CustomCircularProgressIndicator();
                }
              }
          );
        } else if(stateCS is ConfirmedStudentsSectionFailure) {
          return CustomErrorWidget(errorMessage: stateCS.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
