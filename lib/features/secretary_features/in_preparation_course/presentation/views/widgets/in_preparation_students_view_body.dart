import 'dart:developer';

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
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/custom_top_information_field.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/presentation/manager/confirm_reservation_student_cubit/confirm_reservation_student_cubit.dart';
import '../../../../course/presentation/manager/confirm_reservation_student_cubit/confirm_reservation_student_state.dart';
import '../../../../course/presentation/manager/confirmed_students_section_cubit/confirmed_students_section_cubit.dart';
import '../../../../course/presentation/manager/confirmed_students_section_cubit/confirmed_students_section_state.dart';
import '../../../../course/presentation/manager/delete_section_student_cubit/delete_section_student_cubit.dart';
import '../../../../course/presentation/manager/delete_section_student_cubit/delete_section_student_state.dart';
import '../../../../course/presentation/manager/reservation_students_section_cubit/reservation_students_section_cubit.dart';
import '../../../../course/presentation/manager/reservation_students_section_cubit/reservation_students_section_state.dart';

class InPreparationStudentsViewBody extends StatelessWidget {
  const InPreparationStudentsViewBody({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmReservationStudentCubit, ConfirmReservationStudentState>(
        listener: (context, state) {
          if (state is ConfirmReservationStudentFailure) {
            CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('ConfirmReservationStudentFailure'),);
          } else if (state is ConfirmReservationStudentSuccess) {
            CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('ConfirmReservationStudentSuccess'),);
            ConfirmedStudentsSectionCubit.get(context).fetchConfirmedStudentsSection(id: sectionId, page: 1);
            ReservationStudentsSectionCubit.get(context).fetchReservationStudentsSection(id: sectionId, page: 1);
          }
        },
        builder: (contextCR, stateCR) {
          return BlocConsumer<DeleteSectionStudentCubit, DeleteSectionStudentState>(
              listener: (context, state) {
                if (state is DeleteSectionStudentFailure) {
                  CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteSectionStudentFailure'),);
                } else if (state is DeleteSectionStudentSuccess) {
                  CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteSectionStudentSuccess'),);
                  ConfirmedStudentsSectionCubit.get(context).fetchConfirmedStudentsSection(id: sectionId, page: 1);
                  ReservationStudentsSectionCubit.get(context).fetchReservationStudentsSection(id: sectionId, page: 1);
                }
              },
              builder: (contextDS, stateDS) {
                return BlocBuilder<ConfirmedStudentsSectionCubit, ConfirmedStudentsSectionState>(
                    builder: (contextCS, stateCS) {
                      if(stateCS is ConfirmedStudentsSectionSuccess) {
                        return BlocBuilder<ReservationStudentsSectionCubit, ReservationStudentsSectionState>(
                            builder: (contextRS, stateRS) {
                              if(stateRS is ReservationStudentsSectionSuccess) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 56.0.h,),
                                  child: CustomScreenBody(
                                    title: AppLocalizations.of(context).translate('Students'),
                                    textSecondButton: AppLocalizations.of(context).translate('Add student'),
                                    showSecondButton: true,
                                    onPressedFirst: () {},
                                    onPressedSecond: () {
                                      context.go('${GoRouterPath.inPreparationDetails}/${stateCS.confirmedStudents.students.data![0].id}${GoRouterPath.inPreparationStudents}/${stateCS.confirmedStudents.students.data![0].id}${GoRouterPath.searchStudentIp}/${stateCS.confirmedStudents.students.data![0].id}');
                                      //context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/${state.trainers.trainers![0].courseId}${GoRouterPath.sectionTrainers}/${state.trainers.trainers![0].id}${GoRouterPath.searchTrainerSection}/${state.trainers.trainers![0].id}');
                                    },
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
                                              showFirstBox: true,
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
                                                        showIcons: true,
                                                        hideFirstIcon: true,
                                                        hideFirstBox: true,
                                                        onTap: () {
                                                          context.go('${GoRouterPath.studentDetails}/${stateCS.confirmedStudents.students.data![0].students![index].id}');
                                                        },
                                                        onTapFirstIcon: () {},
                                                        onTapSecondIcon: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (
                                                                BuildContext dialogContext) {
                                                              return Align(
                                                                alignment: Alignment.topRight,
                                                                child: Material(
                                                                  color: Colors.transparent,
                                                                  child: Container(
                                                                    width: 638.w,
                                                                    height: 478.h,
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 280.w,
                                                                        vertical: 255.h),
                                                                    padding: EdgeInsets.all(
                                                                        22.r),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.white,
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          6.r),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      physics: BouncingScrollPhysics(),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                                top: 65.h,
                                                                                left: 30.w,
                                                                                right: 155.w),
                                                                            child: Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons
                                                                                      .error_outline,
                                                                                  color: AppColors
                                                                                      .orange,
                                                                                  size: 55.r,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10.w,),
                                                                                Text(
                                                                                  AppLocalizations
                                                                                      .of(
                                                                                      context)
                                                                                      .translate(
                                                                                      'Warning'),
                                                                                  style: Styles
                                                                                      .h3Bold(
                                                                                      color: AppColors
                                                                                          .t3),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                                top: 75.h,
                                                                                left: 65.w,
                                                                                right: 155.w),
                                                                            child: Text(
                                                                              AppLocalizations
                                                                                  .of(context)
                                                                                  .translate(
                                                                                  'Are you sure you want to remove this student from section?'),
                                                                              style: Styles
                                                                                  .b2Normal(
                                                                                  color: AppColors
                                                                                      .t3),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow
                                                                                  .ellipsis,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                                top: 90.h,
                                                                                bottom: 65.h,
                                                                                left: 47.w,
                                                                                right: 155.w),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment
                                                                                  .start,
                                                                              children: [
                                                                                TextIconButton(
                                                                                  textButton: AppLocalizations
                                                                                      .of(
                                                                                      context)
                                                                                      .translate(
                                                                                      'Confirm'),
                                                                                  bigText: true,
                                                                                  textColor: AppColors
                                                                                      .t3,
                                                                                  icon: Icons
                                                                                      .check_circle_outline,
                                                                                  iconSize: 40.01
                                                                                      .r,
                                                                                  iconColor: AppColors
                                                                                      .t2,
                                                                                  iconLast: false,
                                                                                  firstSpaceBetween: 3
                                                                                      .w,
                                                                                  buttonHeight: 53
                                                                                      .h,
                                                                                  borderWidth: 0
                                                                                      .w,
                                                                                  buttonColor: AppColors
                                                                                      .white,
                                                                                  borderColor: Colors
                                                                                      .transparent,
                                                                                  onPressed: () {
                                                                                    context.read<DeleteSectionStudentCubit>().fetchDeleteSectionStudent(sectionId: stateCS.confirmedStudents.students.data![0].id, studentId: stateCS.confirmedStudents.students.data![0].students![index].id);
                                                                                    Navigator.pop(dialogContext);
                                                                                  },
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 42.w,),
                                                                                TextIconButton(
                                                                                  textButton: AppLocalizations
                                                                                      .of(
                                                                                      context)
                                                                                      .translate(
                                                                                      '       Cancel       '),
                                                                                  textColor: AppColors
                                                                                      .t3,
                                                                                  iconLast: false,
                                                                                  buttonHeight: 53
                                                                                      .h,
                                                                                  borderWidth: 0
                                                                                      .w,
                                                                                  borderRadius: 4
                                                                                      .r,
                                                                                  buttonColor: AppColors
                                                                                      .w1,
                                                                                  borderColor: AppColors
                                                                                      .w1,
                                                                                  onPressed: () {
                                                                                    Navigator
                                                                                        .pop(
                                                                                        dialogContext);
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
                                                        showIcons: true,
                                                        hideFirstIcon: true,
                                                        showFirstBox: true,
                                                        onTap: () {
                                                          context.go('${GoRouterPath.studentDetails}/${stateRS.reservationStudents.reservations.data![0].students![index].id}');
                                                        },
                                                        onTapFirstIcon: () {},
                                                        onTapSecondIcon: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (
                                                                BuildContext dialogContext) {
                                                              return Align(
                                                                alignment: Alignment.topRight,
                                                                child: Material(
                                                                  color: Colors.transparent,
                                                                  child: Container(
                                                                    width: 638.w,
                                                                    height: 478.h,
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 280.w,
                                                                        vertical: 255.h),
                                                                    padding: EdgeInsets.all(
                                                                        22.r),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.white,
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          6.r),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      physics: BouncingScrollPhysics(),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                                top: 65.h,
                                                                                left: 30.w,
                                                                                right: 155.w),
                                                                            child: Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons
                                                                                      .error_outline,
                                                                                  color: AppColors
                                                                                      .orange,
                                                                                  size: 55.r,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10.w,),
                                                                                Text(
                                                                                  AppLocalizations
                                                                                      .of(
                                                                                      context)
                                                                                      .translate(
                                                                                      'Warning'),
                                                                                  style: Styles
                                                                                      .h3Bold(
                                                                                      color: AppColors
                                                                                          .t3),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                                top: 75.h,
                                                                                left: 65.w,
                                                                                right: 155.w),
                                                                            child: Text(
                                                                              AppLocalizations
                                                                                  .of(context)
                                                                                  .translate(
                                                                                  'Are you sure you want to remove this student from section?'),
                                                                              style: Styles
                                                                                  .b2Normal(
                                                                                  color: AppColors
                                                                                      .t3),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow
                                                                                  .ellipsis,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                                top: 90.h,
                                                                                bottom: 65.h,
                                                                                left: 47.w,
                                                                                right: 155.w),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment
                                                                                  .start,
                                                                              children: [
                                                                                TextIconButton(
                                                                                  textButton: AppLocalizations
                                                                                      .of(
                                                                                      context)
                                                                                      .translate(
                                                                                      'Confirm'),
                                                                                  bigText: true,
                                                                                  textColor: AppColors
                                                                                      .t3,
                                                                                  icon: Icons
                                                                                      .check_circle_outline,
                                                                                  iconSize: 40.01
                                                                                      .r,
                                                                                  iconColor: AppColors
                                                                                      .t2,
                                                                                  iconLast: false,
                                                                                  firstSpaceBetween: 3
                                                                                      .w,
                                                                                  buttonHeight: 53
                                                                                      .h,
                                                                                  borderWidth: 0
                                                                                      .w,
                                                                                  buttonColor: AppColors
                                                                                      .white,
                                                                                  borderColor: Colors
                                                                                      .transparent,
                                                                                  onPressed: () {
                                                                                    context.read<DeleteSectionStudentCubit>().fetchDeleteSectionStudent(sectionId: stateRS.reservationStudents.reservations.data![0].id, studentId: stateRS.reservationStudents.reservations.data![0].students![index].id);
                                                                                    Navigator
                                                                                        .pop(
                                                                                        dialogContext);
                                                                                  },
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 42.w,),
                                                                                TextIconButton(
                                                                                  textButton: AppLocalizations
                                                                                      .of(
                                                                                      context)
                                                                                      .translate(
                                                                                      '       Cancel       '),
                                                                                  textColor: AppColors
                                                                                      .t3,
                                                                                  iconLast: false,
                                                                                  buttonHeight: 53
                                                                                      .h,
                                                                                  borderWidth: 0
                                                                                      .w,
                                                                                  borderRadius: 4
                                                                                      .r,
                                                                                  buttonColor: AppColors
                                                                                      .w1,
                                                                                  borderColor: AppColors
                                                                                      .w1,
                                                                                  onPressed: () {
                                                                                    Navigator
                                                                                        .pop(
                                                                                        dialogContext);
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
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 280.w,
                                                                        vertical: 255.h),
                                                                    padding: EdgeInsets.all(
                                                                        22.r),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors.white,
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          6.r),
                                                                    ),
                                                                    child: SingleChildScrollView(
                                                                      physics: BouncingScrollPhysics(),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                                top: 65.h,
                                                                                left: 30.w,
                                                                                right: 155.w),
                                                                            child: Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons
                                                                                      .error_outline,
                                                                                  color: AppColors
                                                                                      .orange,
                                                                                  size: 55.r,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10.w,),
                                                                                Text(
                                                                                  AppLocalizations
                                                                                      .of(
                                                                                      context)
                                                                                      .translate(
                                                                                      'Warning'),
                                                                                  style: Styles
                                                                                      .h3Bold(
                                                                                      color: AppColors
                                                                                          .t3),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                                top: 75.h,
                                                                                left: 65.w,
                                                                                right: 155.w),
                                                                            child: Text(
                                                                              AppLocalizations
                                                                                  .of(context)
                                                                                  .translate(
                                                                                  'Are you sure you want to confirm reservation for this student?'),
                                                                              style: Styles
                                                                                  .b2Normal(
                                                                                  color: AppColors
                                                                                      .t3),
                                                                              maxLines: 1,
                                                                              overflow: TextOverflow
                                                                                  .ellipsis,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets
                                                                                .only(
                                                                                top: 90.h,
                                                                                bottom: 65.h,
                                                                                left: 47.w,
                                                                                right: 155.w),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment
                                                                                  .start,
                                                                              children: [
                                                                                TextIconButton(
                                                                                  textButton: AppLocalizations
                                                                                      .of(
                                                                                      context)
                                                                                      .translate(
                                                                                      'Confirm'),
                                                                                  bigText: true,
                                                                                  textColor: AppColors
                                                                                      .t3,
                                                                                  icon: Icons
                                                                                      .check_circle_outline,
                                                                                  iconSize: 40.01
                                                                                      .r,
                                                                                  iconColor: AppColors
                                                                                      .t2,
                                                                                  iconLast: false,
                                                                                  firstSpaceBetween: 3
                                                                                      .w,
                                                                                  buttonHeight: 53
                                                                                      .h,
                                                                                  borderWidth: 0
                                                                                      .w,
                                                                                  buttonColor: AppColors
                                                                                      .white,
                                                                                  borderColor: Colors
                                                                                      .transparent,
                                                                                  onPressed: () {
                                                                                    log(stateRS.reservationStudents.reservations.data![0].students![index].pivot.id.toString());
                                                                                    ConfirmReservationStudentCubit.get(context).fetchConfirmReservationStudent(reservationId: stateRS.reservationStudents.reservations.data![0].students![index].pivot.id);
                                                                                    Navigator
                                                                                        .pop(
                                                                                        dialogContext);
                                                                                  },
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 42.w,),
                                                                                TextIconButton(
                                                                                  textButton: AppLocalizations
                                                                                      .of(
                                                                                      context)
                                                                                      .translate(
                                                                                      '       Cancel       '),
                                                                                  textColor: AppColors
                                                                                      .t3,
                                                                                  iconLast: false,
                                                                                  buttonHeight: 53
                                                                                      .h,
                                                                                  borderWidth: 0
                                                                                      .w,
                                                                                  borderRadius: 4
                                                                                      .r,
                                                                                  buttonColor: AppColors
                                                                                      .w1,
                                                                                  borderColor: AppColors
                                                                                      .w1,
                                                                                  onPressed: () {
                                                                                    Navigator
                                                                                        .pop(
                                                                                        dialogContext);
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
          );
        }
    );
  }
}
