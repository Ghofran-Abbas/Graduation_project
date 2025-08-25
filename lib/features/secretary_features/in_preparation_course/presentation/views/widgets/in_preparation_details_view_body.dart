import 'dart:developer';

import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:alhadara_dashboard/core/utils/assets.dart';
import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_multiple_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/presentation/manager/create_section_cubit/create_section_cubit.dart';
import '../../../../course/presentation/manager/create_section_cubit/create_section_state.dart';
import '../../../../course/presentation/manager/delete_section_cubit/delete_section_cubit.dart';
import '../../../../course/presentation/manager/delete_section_cubit/delete_section_state.dart';
import '../../../../course/presentation/manager/details_course_cubit/details_course_cubit.dart';
import '../../../../course/presentation/manager/details_course_cubit/details_course_state.dart';
import '../../../../course/presentation/manager/sections_cubit/sections_cubit.dart';
import '../../../../course/presentation/manager/sections_cubit/sections_state.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_state.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';
import '../../../../course/presentation/manager/update_section_cubit/update_section_cubit.dart';
import '../../../../course/presentation/manager/update_section_cubit/update_section_state.dart';
import '../../../../course/presentation/manager/update_state_section_cubit/update_state_section_cubit.dart';
import '../../../../course/presentation/manager/update_state_section_cubit/update_state_section_state.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';
import '../../../data/models/in_preparation_model.dart';
import '../../manager/in_preparation_cubit/in_preparation_cubit.dart';
import '../../manager/in_preparation_cubit/in_preparation_state.dart';

class DetailsInPreparationViewBody extends StatelessWidget {
  DetailsInPreparationViewBody({super.key, required this.courseId});

  final int courseId;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController sundayStartController = TextEditingController();
  final TextEditingController sundayEndController = TextEditingController();
  final TextEditingController mondayStartController = TextEditingController();
  final TextEditingController mondayEndController = TextEditingController();
  final TextEditingController tuesdayStartController = TextEditingController();
  final TextEditingController tuesdayEndController = TextEditingController();
  final TextEditingController wednesdayStartController = TextEditingController();
  final TextEditingController wednesdayEndController = TextEditingController();
  final TextEditingController thursdayStartController = TextEditingController();
  final TextEditingController thursdayEndController = TextEditingController();
  final TextEditingController fridayStartController = TextEditingController();
  final TextEditingController fridayEndController = TextEditingController();
  final TextEditingController saturdayStartController = TextEditingController();
  final TextEditingController saturdayEndController = TextEditingController();

  final List<String> dayOptions = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday',];
  final List<String> statusOptions = ['Pending', 'In progress', 'Finished',];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateSectionCubit, UpdateSectionState>(
      listener: (context, state) {
        if (state is UpdateSectionFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateSectionFailure'),);
        } else if (state is UpdateSectionSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateSectionSuccess'),);
          context.read<SelectInPreparationCubit>().clearSelection();
          context.read<InPreparationCubit>().fetchInPreparation(courseId: courseId, page: 1);
          context.read<DetailsCourseCubit>().fetchDetailsCourse(id: courseId);
        }
      },
      builder: (context, state) {
        return BlocConsumer<UpdateStateSectionCubit, UpdateStateSectionState>(
            listener: (contextUS, stateUS) {
              if (stateUS is UpdateStateSectionFailure) {
                CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateSectionFailure'),);
              } else if (stateUS is UpdateStateSectionSuccess) {
                CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateSectionSuccess'),);
                context.read<SelectInPreparationCubit>().clearSelection();
                context.read<InPreparationCubit>().fetchInPreparation(courseId: courseId, page: 1);
                context.read<DetailsCourseCubit>().fetchDetailsCourse(id: courseId);
              }
            },
            builder: (contextUS, stateUS) {
            return BlocConsumer<DeleteSectionCubit, DeleteSectionState>(
              listener: (context, state) {
                if (state is DeleteSectionFailure) {
                  CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteSectionFailure'),);
                } else if (state is DeleteSectionSuccess) {
                  CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteSectionSuccess'),);
                  context.read<SelectInPreparationCubit>().clearSelection();
                  context.read<InPreparationCubit>().fetchInPreparation(courseId: courseId, page: 1);
                  context.read<DetailsCourseCubit>().fetchDetailsCourse(id: courseId);
                }
              },
              builder: (context, state) {
                return BlocConsumer<DetailsCourseCubit, DetailsCourseState>(
                  listener: (contextDC, stateDC) {},
                  builder: (contextDC, stateDC)  {
                    if(stateDC is DetailsCourseSuccess) {
                      return BlocConsumer<InPreparationCubit, InPreparationState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is InPreparationSuccess) {
                            final List<DatumInPreparation> sections = state.createResult.data!;
                            final current = state.currentPage;
                            final last = state.lastPage;
                            return Padding(
                              padding: EdgeInsets.only(top: 56.0.h,),
                              child: CustomScreenBody(
                                title: stateDC.course.course.name,
                                textFirstButton: 'Section 2',
                                showFirstButton: true,
                                widget: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.chevron_left, color: current > 1
                                          ? AppColors.purple
                                          : AppColors.t0
                                      ),
                                      onPressed: current > 1
                                          ? () => context.read<InPreparationCubit>()
                                          .fetchInPreparation(courseId: courseId, page: current - 1)
                                          : null,
                                    ),
                                    SizedBox(
                                      width: 200.w,
                                      child: BlocBuilder<SelectInPreparationCubit, SelectInPreparationState>(
                                        builder: (context, selectState) {
                                          DatumInPreparation? selected;
                                          if (selectState is SelectInPreparationSuccess) {
                                            selected = selectState.section;
                                          }
                                          return Padding(
                                            padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
                                            child: DropdownMenu<DatumInPreparation>(
                                              enableSearch: false,
                                              requestFocusOnTap: false,
                                              width: 200.w,
                                              hintText: AppLocalizations.of(context).translate('No section'),
                                              initialSelection: selected,
                                              inputDecorationTheme: InputDecorationTheme(
                                                constraints: BoxConstraints(
                                                    maxHeight: 53.h),
                                                hintStyle: Styles.l1Normal(
                                                    color: AppColors.t0),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppColors.purple,
                                                    width: 1.23,
                                                  ),
                                                  borderRadius: BorderRadius.circular(
                                                      24.67.r),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppColors.purple,
                                                    width: 1.23,
                                                  ),
                                                  borderRadius: BorderRadius.circular(
                                                      24.67.r),
                                                ),
                                              ),
                                              alignmentOffset: Offset(4, 2),
                                              menuStyle: MenuStyle(
                                                backgroundColor: WidgetStateColor
                                                    .resolveWith(
                                                      (states) {
                                                    return AppColors.white;
                                                  },
                                                ),
                                                elevation: WidgetStateProperty.resolveWith(
                                                      (states) {
                                                    return 0;
                                                  },
                                                ),
                                                side: WidgetStateBorderSide.resolveWith(
                                                      (states) {
                                                    return BorderSide(
                                                      width: 1.23,
                                                      color: AppColors.purple,

                                                    );
                                                  },
                                                ),

                                              ),
                                              dropdownMenuEntries: sections.map((section) {
                                                return DropdownMenuEntry<DatumInPreparation>(
                                                  value: section,
                                                  label: section.name,
                                                );
                                              }).toList(),
                                              onSelected: (DatumInPreparation? selectedSection) {
                                                if (selectedSection != null) {
                                                  BlocProvider.of<SelectInPreparationCubit>(context).selectSection(section: selectedSection);
                                                  log('Selected ID: ${selectedSection.id}');
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.chevron_right, color: current < last
                                          ? AppColors.purple
                                          : AppColors.t0),
                                      onPressed: current < last
                                          ? () => context.read<InPreparationCubit>()
                                          .fetchInPreparation(courseId: courseId, page: current + 1)
                                          : null,
                                    ),
                                  ],
                                ),
                                showButtonIcon: true,
                                onPressedFirst: (){},
                                onPressedSecond: (){},
                                body: BlocConsumer<SelectInPreparationCubit, SelectInPreparationState>(
                                  listener: (contextSec, stateSec) {
                                    if (stateSec is SelectInPreparationSuccess) {
                                      TrainersSectionCubit.get(context).fetchTrainersSection(id: stateSec.section.id, page: 1);
                                      StudentsSectionCubit.get(context).fetchStudentsSection(id: stateSec.section.id, page: 1);
                                    }
                                  },
                                  builder: (context, stateSec) {
                                    if (stateSec is SelectInPreparationSuccess) {
                                      return BlocConsumer<TrainersSectionCubit, TrainersSectionState>(
                                        listener: (contextTS, stateTS) {},
                                        builder: (contextTS, stateTS) {
                                          return BlocBuilder<StudentsSectionCubit, StudentsSectionState>(
                                              builder: (contextSS, stateSS) {
                                              return Padding(
                                                padding: EdgeInsets.only(top: 238.0.h, left: 77.0.w, bottom: 27.0.h),
                                                child: SingleChildScrollView(
                                                  physics: BouncingScrollPhysics(),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          CustomCourseInformation(
                                                            image: stateDC.course.course.photo,
                                                            showIcons: true,
                                                            showSectionInformation: true,
                                                            ratingText: '0.0',
                                                            ratingPercent: 0,
                                                            ratingPercentText: '0%',
                                                            circleStatusColor: AppColors.mintGreen,
                                                            courseStatusText: handleReceiveState(state: stateSec.section.state),
                                                            showEditStatusIcon: true,
                                                            startDateText: stateSec.section.startDate.toString().replaceRange(10, 23, ''),
                                                            showCourseCalenderIcon: true,
                                                            endDateText: stateSec.section.endDate.toString().replaceRange(10, 23, ''),
                                                            numberSeatsText: '${stateSec.section.seatsOfNumber} ${AppLocalizations.of(context).translate('Seats')}',
                                                            bodyText: stateDC.course.course.description,
                                                            onTap: (){
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext dialogContext) {
                                                                  return UpdateStateDialog(section: stateSec.section, updateCubit: context.read<UpdateStateSectionCubit>(),);
                                                                },
                                                              );
                                                            },
                                                            onTapDate: (){
                                                              context.go('${GoRouterPath.inPreparationDetails}/$courseId${GoRouterPath.inPreparationCalendar}/${stateSec.section.id}');
                                                            },
                                                            onTapFirstIcon: (){
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext dialogContext) {
                                                                  return UpdateSectionDialog(section: stateSec.section, courseId: stateDC.course.course.id, updateCubit: context.read<UpdateSectionCubit>(),);
                                                                },
                                                              );
                                                            },
                                                            onTapSecondIcon: (){
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
                                                                                  AppLocalizations.of(context).translate('Are you sure you want to delete this section?'),
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
                                                                                        context.read<DeleteSectionCubit>().fetchDeleteSection(id: stateSec.section.id);
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
                                                          ),
                                                          SizedBox(height: 22.h),
                                                          Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              BlocBuilder<StudentsSectionCubit, StudentsSectionState>(
                                                                  builder: (contextSS, stateSS) {
                                                                    if(stateSS is StudentsSectionSuccess) {
                                                                      return Row(
                                                                        children: [
                                                                          CustomOverloadingAvatar(
                                                                            labelText: '${AppLocalizations.of(context).translate('Look at')} ${stateSS.students.students.data![0].students!.length} ${AppLocalizations.of(context).translate('students in this class')}',
                                                                            tailText: AppLocalizations.of(context).translate('See more'),
                                                                            firstImage: stateSS.students.students.data![0].students!.isNotEmpty ? stateSS.students.students.data![0].students![0].photo : '',
                                                                            secondImage: stateSS.students.students.data![0].students!.length >= 2 ? stateSS.students.students.data![0].students![1].photo : '',
                                                                            thirdImage: stateSS.students.students.data![0].students!.length >= 3 ? stateSS.students.students.data![0].students![2].photo : '',
                                                                            fourthImage: stateSS.students.students.data![0].students!.length >= 4 ? stateSS.students.students.data![0].students![3].photo : '',
                                                                            fifthImage: stateSS.students.students.data![0].students!.length >= 5 ? stateSS.students.students.data![0].students![4].photo : '',
                                                                            avatarCount: stateSS.students.students.data![0].students!.length,
                                                                            onTap: () {context.go('${GoRouterPath.inPreparationDetails}/${stateSS.students.students.data![0].id}${GoRouterPath.inPreparationStudents}/${stateSS.students.students.data![0].id}');
                                                                            //onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            width: calculateWidthBetweenAvatars(avatarCount: stateSS.students.students.data![0].students!.length) /*270.w*/,),
                                                                        ],
                                                                      );
                                                                    } else if(stateSS is StudentsSectionFailure) {
                                                                      return Row(
                                                                        children: [
                                                                          CustomOverloadingAvatar(
                                                                            labelText: '${AppLocalizations.of(context).translate('Look at')} ${AppLocalizations.of(context).translate('students in this class')}',
                                                                            tailText: AppLocalizations.of(context).translate('See more'),
                                                                            firstImage: '',
                                                                            secondImage: '',
                                                                            thirdImage: '',
                                                                            fourthImage: '',
                                                                            fifthImage: '',
                                                                            avatarCount: 5,
                                                                            onTap: () {//context.go('${GoRouterPath.inPreparationDetails}/1${GoRouterPath.inPreparationTrainers}/1');
                                                                            //onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            width: calculateWidthBetweenAvatars(avatarCount: 5) /*270.w*/,),
                                                                        ],
                                                                      );
                                                                    } else {
                                                                      return CustomCircularProgressIndicator();
                                                                    }
                                                                  }
                                                              ),
                                                              BlocBuilder<TrainersSectionCubit, TrainersSectionState>(
                                                                  builder: (contextTS, stateTS) {
                                                                    if(stateTS is TrainersSectionSuccess) {
                                                                      return Expanded(
                                                                        child: CustomOverloadingAvatar(
                                                                          labelText: '${AppLocalizations.of(context).translate('Look at')} ${stateTS.trainers.trainers![0].trainers!.length} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                                                          tailText: AppLocalizations.of(context).translate('See more'),
                                                                          firstImage: stateTS.trainers.trainers![0].trainers!.isNotEmpty ? stateTS.trainers.trainers![0].trainers![0].photo : '',
                                                                          secondImage: stateTS.trainers.trainers![0].trainers!.length >= 2 ? stateTS.trainers.trainers![0].trainers![1].photo : '',
                                                                          thirdImage: stateTS.trainers.trainers![0].trainers!.length >= 3 ? stateTS.trainers.trainers![0].trainers![2].photo : '',
                                                                          fourthImage: stateTS.trainers.trainers![0].trainers!.length >= 4 ? stateTS.trainers.trainers![0].trainers![3].photo : '',
                                                                          fifthImage: stateTS.trainers.trainers![0].trainers!.length >= 5 ? stateTS.trainers.trainers![0].trainers![4].photo : '',
                                                                          avatarCount: stateTS.trainers.trainers![0].trainers!.length,
                                                                          onTap: () {
                                                                            context.go('${GoRouterPath.inPreparationDetails}/${stateTS.trainers.trainers![0].id}${GoRouterPath.inPreparationTrainers}/${stateTS.trainers.trainers![0].id}');
                                                                            //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionTrainers}/${state.section.id}');
                                                                          },
                                                                        ),
                                                                      );
                                                                    } else if(stateTS is TrainersSectionFailure) {
                                                                      return Row(
                                                                        children: [
                                                                          CustomOverloadingAvatar(
                                                                            labelText: '${AppLocalizations.of(context).translate('Look at')} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                                                            tailText: AppLocalizations.of(context).translate('See more'),
                                                                            firstImage: '',
                                                                            secondImage: '',
                                                                            thirdImage: '',
                                                                            fourthImage: '',
                                                                            fifthImage: '',
                                                                            avatarCount: 5,
                                                                            onTap: () {//context.go('${GoRouterPath.inPreparationDetails}/2${GoRouterPath.inPreparationTrainers}/1');
                                                                              //onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            width: calculateWidthBetweenAvatars(avatarCount: 5) /*270.w*/,),
                                                                        ],
                                                                      );
                                                                    } else {
                                                                      return CustomCircularProgressIndicator();
                                                                    }
                                                                  }
                                                              ),
                                                            ],
                                                          ),
                                                          /*Padding(
                                                            padding: EdgeInsets.only(top: 40.h, right: 47.0.w,),
                                                            child: DefaultTabController(
                                                              length: 2,
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 70.h,
                                                                    child: TabBar(
                                                                      labelColor: AppColors.blue,
                                                                      unselectedLabelColor: AppColors.blue,
                                                                      indicator: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        color: AppColors.darkBlue,
                                                                      ),
                                                                      indicatorPadding: EdgeInsets.only(top: 48.r, bottom: 12.r),
                                                                      indicatorWeight: 20,
                                                                      labelStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                                                      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                                                                      tabs: [
                                                                        Tab(text: AppLocalizations.of(context).translate('         File         '),),
                                                                        Tab(text: AppLocalizations.of(context).translate('Announcement')),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 570.23.h,
                                                                    child: TabBarView(
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize: MainAxisSize.max,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            CustomEmptyWidget(
                                                                              firstText: AppLocalizations.of(context).translate('No files in this section at this time'),
                                                                              secondText: AppLocalizations.of(context).translate('Files will appear here after they add to the section.'),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize: MainAxisSize.max,
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            //Image(image: AssetImage(Assets.empty)),
                                                                            Expanded(
                                                                              child: Text(
                                                                                AppLocalizations.of(context).translate('No courses at this time'),
                                                                                style: Styles.h3Bold(color: AppColors.t3),
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Text(
                                                                                AppLocalizations.of(context).translate('Courses will appear here after they enroll in your school.'),
                                                                                style: Styles.l1Normal(color: AppColors.t3),
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),*/
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          );
                                        }
                                      );
                                    } else {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: 238.0.h,
                                            left: 77.0.w,
                                            bottom: 27.0.h),
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Column(
                                                children: [
                                                  CustomCourseInformation(
                                                    image: stateDC.course.course.photo,
                                                    bodyText: stateDC.course.course.description,
                                                    onTap: () {},
                                                    onTapDate: () {},
                                                    onTapFirstIcon: (){},
                                                    onTapSecondIcon: (){},
                                                  ),
                                                  //SizedBox(height: 22.h),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 87.w),
                                                    child: CustomEmptyWidget(
                                                      firstText: AppLocalizations.of(context).translate('No more at this time'),
                                                      secondText: AppLocalizations.of(context).translate('Add a section to see more options.'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                ),
                              ),
                            );
                          } else if (state is InPreparationFailure) {
                            return CustomErrorWidget(
                                errorMessage: state.errorMessage);
                          } else {
                            return CustomCircularProgressIndicator();
                          }
                        }
                      );
                    } else if(stateDC is DetailsCourseFailure) {
                      return CustomErrorWidget(
                          errorMessage: stateDC.errorMessage);
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
    );
  }
}

class UpdateSectionDialog extends StatefulWidget {
  const UpdateSectionDialog({super.key, required this.section, required this.courseId, required this.updateCubit});

  final int courseId;
  final DatumInPreparation section;
  final UpdateSectionCubit updateCubit;

  @override
  State<UpdateSectionDialog> createState() => _UpdateSectionDialogState();
}

class _UpdateSectionDialogState extends State<UpdateSectionDialog> {
  late TextEditingController nameController;
  late TextEditingController seatsController;
  late TextEditingController statusController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController sundayStartController;
  late TextEditingController sundayEndController;
  late TextEditingController mondayStartController;
  late TextEditingController mondayEndController;
  late TextEditingController tuesdayStartController;
  late TextEditingController tuesdayEndController;
  late TextEditingController wednesdayStartController;
  late TextEditingController wednesdayEndController;
  late TextEditingController thursdayStartController;
  late TextEditingController thursdayEndController;
  late TextEditingController fridayStartController;
  late TextEditingController fridayEndController;
  late TextEditingController saturdayStartController;
  late TextEditingController saturdayEndController;
  late TextEditingController sessionsController;

  late final String originalName;
  late final String originalSeats;
  late final String originalStartDate;
  late final String originalEndDate;
  late final List<String> originalSelectedDays;
  late final Map<String, Map<String, String>> originalTimesPerDay;
  late final String originalSessions;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    originalName = widget.section.name;
    originalSeats = widget.section.seatsOfNumber.toString();
    originalStartDate = widget.section.startDate.toString().split(' ')[0];
    originalEndDate = widget.section.endDate.toString().split(' ')[0];
    originalSelectedDays = [];
    originalTimesPerDay = {};
    originalSessions = widget.section.totalSessions.toString();

    nameController = TextEditingController(text: originalName);
    seatsController = TextEditingController(text: originalSeats);
    statusController = TextEditingController(text: widget.section.state);
    startDateController = TextEditingController(text: originalStartDate);
    endDateController = TextEditingController(text: originalEndDate);

    sundayStartController = TextEditingController();
    sundayEndController = TextEditingController();
    mondayStartController = TextEditingController();
    mondayEndController = TextEditingController();
    tuesdayStartController = TextEditingController();
    tuesdayEndController = TextEditingController();
    wednesdayStartController = TextEditingController();
    wednesdayEndController = TextEditingController();
    thursdayStartController = TextEditingController();
    thursdayEndController = TextEditingController();
    fridayStartController = TextEditingController();
    fridayEndController = TextEditingController();
    saturdayStartController = TextEditingController();
    saturdayEndController = TextEditingController();

    sessionsController = TextEditingController(text: originalSessions);

    for (var day in widget.section.weekDays) {
      final dayName = (day['name'] as String).toLowerCase();
      final capitalized = dayName[0].toUpperCase() + dayName.substring(1);
      originalSelectedDays.add(capitalized);

      final startTime = day['pivot']?['start_time'].toString().replaceRange(5, 8, '') ?? '';
      final endTime = day['pivot']?['end_time'].toString().replaceRange(5, 8, '') ?? '';
      originalTimesPerDay[capitalized] = {
        "start_time": startTime,
        "end_time": endTime,
      };

      switch (dayName) {
        case 'sunday':
          sundayStartController.text = startTime;
          sundayEndController.text = endTime;
          break;
        case 'monday':
          mondayStartController.text = startTime;
          mondayEndController.text = endTime;
          break;
        case 'tuesday':
          tuesdayStartController.text = startTime;
          tuesdayEndController.text = endTime;
          break;
        case 'wednesday':
          wednesdayStartController.text = startTime;
          wednesdayEndController.text = endTime;
          break;
        case 'thursday':
          thursdayStartController.text = startTime;
          thursdayEndController.text = endTime;
          break;
        case 'friday':
          fridayStartController.text = startTime;
          fridayEndController.text = endTime;
          break;
        case 'saturday':
          saturdayStartController.text = startTime;
          saturdayEndController.text = endTime;
          break;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    seatsController.dispose();
    statusController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    sundayStartController.dispose();
    sundayEndController.dispose();
    mondayStartController.dispose();
    mondayEndController.dispose();
    tuesdayStartController.dispose();
    tuesdayEndController.dispose();
    wednesdayStartController.dispose();
    wednesdayEndController.dispose();
    thursdayStartController.dispose();
    thursdayEndController.dispose();
    fridayStartController.dispose();
    fridayEndController.dispose();
    saturdayStartController.dispose();
    saturdayEndController.dispose();
    sessionsController.dispose();
    super.dispose();
  }

  final List<String> dayOptions = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday',];

  List<String> selectedDays = [];

  bool _areListsEqual(List<String> a, List<String> b) {
    final aSorted = a.map((e) => e.toLowerCase()).toList()..sort();
    final bSorted = b.map((e) => e.toLowerCase()).toList()..sort();
    return listEquals(aSorted, bSorted);
  }

  bool _areDayTimesEqual(
      Map<String, Map<String, String>> current,
      Map<String, Map<String, String>> original,
      ) {
    for (final day in current.keys) {
      final currStart = (current[day]?['start_time'] ?? '').trim();
      final currEnd = (current[day]?['end_time'] ?? '').trim();
      final origStart = (original[day]?['start_time'] ?? '').trim();
      final origEnd = (original[day]?['end_time'] ?? '').trim();

      if (currStart != origStart || currEnd != origEnd) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
    final selectedDaysFromSection = widget.section.weekDays
        .map((day) => capitalize(day['name'])) // تحويل مثل "sunday" => "Sunday"
        .toList();
    return BlocProvider(
      create: (_) => MultiCheckboxCubit()..initializeSelectedItems(selectedDaysFromSection),
      child: BlocBuilder<MultiCheckboxCubit, MultiCheckboxState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 871.w,
                height: 918.h,
                margin: EdgeInsets.symmetric(horizontal: 160.w, vertical: 55.h),
                padding: EdgeInsets.all(22.r),
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
                        padding: EdgeInsets.only(
                            top: 65.h,
                            left: 60.w,
                            right: 155.w),
                        child: Text(
                          AppLocalizations.of(context).translate('Edit section'),
                          style: Styles.h3Bold(
                              color: AppColors.t3),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 155.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomLabelTextFormField(
                                labelText: AppLocalizations.of(context).translate('Name'),
                                showLabelText: true,
                                controller: nameController,
                                topPadding: 60.h,
                                rightPadding: 0.w,
                                bottomPadding: 0.h,
                              ),
                            ),
                            SizedBox(width: 19.w,),
                            Expanded(
                              flex: 1,
                              child: CustomLabelTextFormField(
                                labelText: AppLocalizations.of(context).translate('Sessions number'),
                                showLabelText: true,
                                controller: sessionsController,
                                topPadding: 60.h,
                                leftPadding: 0.w,
                                rightPadding: 0.w,
                                bottomPadding: 0.h,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 60.w,
                            right: 155.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomLabelTextFormField(
                                labelText: AppLocalizations.of(context).translate('Seats number'),
                                showLabelText: true,
                                controller: seatsController,
                                topPadding: 38.h,
                                leftPadding: 0.w,
                                rightPadding: 0.w,
                                bottomPadding: 38.h,
                              ),
                            ),
                            /*SizedBox(width: 19.w,),
                            Expanded(
                              flex: 1,
                              child: CustomDropdownList(
                                hintText: AppLocalizations.of(context).translate('Status'),
                                statusController: statusController,
                                dropdownMenuEntries: [
                                  DropdownMenuEntry(
                                    value: 'In preparation',
                                    label: AppLocalizations.of(context).translate('In preparation'),
                                  ),
                                  DropdownMenuEntry(
                                    value: 'Active now',
                                    label: AppLocalizations.of(context).translate('Active now'),
                                  ),
                                  DropdownMenuEntry(
                                    value: 'Complete',
                                    label: AppLocalizations.of(context).translate('Complete'),
                                  ),
                                ],
                              ),
                            ),*/
                            SizedBox(width: 19.w,),
                            Expanded(
                              flex: 1,
                              child: CustomLabelTextFormField(
                                hintText: AppLocalizations.of(context).translate('Start date'),
                                readOnly: true,
                                controller: startDateController,
                                topPadding: 65.h,
                                leftPadding: 0.w,
                                rightPadding: 0.w,
                                bottomPadding: 33.h,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: startDateController.text.isEmpty ? DateTime.now() : DateTime.parse(startDateController.text),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    startDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate).toString();
                                    endDateController.clear();
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 19.w,),
                            Expanded(
                              flex: 1,
                              child: CustomLabelTextFormField(
                                hintText: AppLocalizations.of(context).translate('End date'),
                                readOnly: true,
                                controller: endDateController,
                                topPadding: 65.h,
                                leftPadding: 0.w,
                                rightPadding: 0.w,
                                bottomPadding: 38.h,
                                onTap: () async {
                                  if (startDateController.text.isEmpty) {
                                    CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('SelectEndDateFailure'),);
                                    return;
                                  }

                                  DateTime parsedStartDate = DateTime.parse(startDateController.text);
                                  DateTime initialEndDate = parsedStartDate.add(Duration(days: 1));

                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: endDateController.text.isEmpty
                                        ? initialEndDate
                                        : DateTime.parse(endDateController.text),
                                    firstDate: initialEndDate,
                                    lastDate: DateTime(2100),
                                  );

                                  if (pickedDate != null) {
                                    endDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate).toString();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 38.h,
                            left: 60.w,
                            right: 55.w),
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .max,
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: EdgeInsets
                                  .only(
                                  left: 0.w,
                                  bottom: 4.h),
                              child: Text(
                                AppLocalizations.of(context).translate('Class days'),
                                style: Styles
                                    .l1Normal(
                                    color: AppColors
                                        .t2),
                                maxLines: 1,
                                overflow: TextOverflow
                                    .ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 728.w,
                              child: Wrap(
                                spacing: 12.w,
                                runSpacing: 8,
                                children: dayOptions.map((option) {
                                  final isSelected = state.selectedItems.contains(option);
                                  selectedDays = state.selectedItems;
                                  return CustomMultipleCheckBox(
                                    isSelected: isSelected,
                                    option: option,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 60.w,
                            right: 155.w),
                        child: Wrap(
                          children: [
                            selectedDays.contains(
                                'Sunday')
                                ? SizedBox(
                              width: 187.w,
                              child: CustomStartEndTimePicker(
                                dayName: AppLocalizations.of(context).translate('Sunday'),
                                startTimeController: sundayStartController,
                                endTimeController: sundayEndController,
                              ),
                            )
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),
                            selectedDays.contains(
                                'Sunday')
                                ? SizedBox(
                              width: 13.w,)
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),

                            selectedDays.contains(
                                'Monday')
                                ? SizedBox(
                              width: 187.w,
                              child: CustomStartEndTimePicker(
                                dayName: AppLocalizations.of(context).translate('Monday'),
                                startTimeController: mondayStartController,
                                endTimeController: mondayEndController,
                              ),
                            )
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),
                            selectedDays.contains(
                                'Monday')
                                ? SizedBox(
                              width: 13.w,)
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),

                            selectedDays.contains(
                                'Tuesday')
                                ? SizedBox(
                              width: 187.w,
                              child: CustomStartEndTimePicker(
                                dayName: AppLocalizations.of(context).translate('Tuesday'),
                                startTimeController: tuesdayStartController,
                                endTimeController: tuesdayEndController,
                              ),
                            )
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),
                            selectedDays.contains(
                                'Tuesday')
                                ? SizedBox(
                              width: 13.w,)
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),

                            selectedDays.contains(
                                'Wednesday')
                                ? SizedBox(
                              width: 187.w,
                              child: CustomStartEndTimePicker(
                                dayName: AppLocalizations.of(context).translate('Wednesday'),
                                startTimeController: wednesdayStartController,
                                endTimeController: wednesdayEndController,
                              ),
                            )
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),
                            selectedDays.contains(
                                'Wednesday')
                                ? SizedBox(
                              width: 13.w,)
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),

                            selectedDays.contains(
                                'Thursday')
                                ? SizedBox(
                              width: 187.w,
                              child: CustomStartEndTimePicker(
                                dayName: AppLocalizations.of(context).translate('Thursday'),
                                startTimeController: thursdayStartController,
                                endTimeController: thursdayEndController,
                              ),
                            )
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),
                            selectedDays.contains(
                                'Thursday')
                                ? SizedBox(
                              width: 13.w,)
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),

                            selectedDays.contains(
                                'Friday')
                                ? SizedBox(
                              width: 187.w,
                              child: CustomStartEndTimePicker(
                                dayName: AppLocalizations.of(context).translate('Friday'),
                                startTimeController: fridayStartController,
                                endTimeController: fridayEndController,
                              ),
                            )
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),
                            selectedDays.contains(
                                'Friday')
                                ? SizedBox(
                              width: 13.w,)
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),

                            selectedDays.contains(
                                'Saturday')
                                ? SizedBox(
                              width: 187.w,
                              child: CustomStartEndTimePicker(
                                dayName: AppLocalizations.of(context).translate('Saturday'),
                                startTimeController: saturdayStartController,
                                endTimeController: saturdayEndController,
                              ),
                            )
                                : SizedBox(
                              width: 0.w,
                              height: 0.h,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 22.h, bottom: 65.h, left: 47.w, right: 155.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextIconButton(
                                textButton: AppLocalizations.of(context).translate('Edit section'),
                                bigText: true,
                                textColor: AppColors.t3,
                                icon: Icons.add,
                                iconSize: 40.01.r,
                                iconColor: AppColors.t2,
                                iconLast: false,
                                firstSpaceBetween: 3.w,
                                buttonHeight: 53.h,
                                borderWidth: 0.w,
                                buttonColor: AppColors.white,
                                borderColor: Colors.transparent,
                                onPressed: () {
                                  final selectedDays = context.read<MultiCheckboxCubit>().state.selectedItems;
                                  final currentTimes = {
                                    'Sunday': {
                                      'start_time': sundayStartController.text,
                                      'end_time': sundayEndController.text,
                                    },
                                    'Monday': {
                                      'start_time': mondayStartController.text,
                                      'end_time': mondayEndController.text,
                                    },
                                    'Tuesday': {
                                      'start_time': tuesdayStartController.text,
                                      'end_time': tuesdayEndController.text,
                                    },
                                    'Wednesday': {
                                      'start_time': wednesdayStartController.text,
                                      'end_time': wednesdayEndController.text,
                                    },
                                    'Thursday': {
                                      'start_time': thursdayStartController.text,
                                      'end_time': thursdayEndController.text,
                                    },
                                    'Friday': {
                                      'start_time': fridayStartController.text,
                                      'end_time': fridayEndController.text,
                                    },
                                    'Saturday': {
                                      'start_time': saturdayStartController.text,
                                      'end_time': saturdayEndController.text,
                                    },
                                  };
                                  final hasChanged =
                                      nameController.text != originalName ||
                                          seatsController.text != originalSeats ||
                                          startDateController.text != originalStartDate ||
                                          endDateController.text != originalEndDate ||
                                          !_areListsEqual(selectedDays, originalSelectedDays) ||
                                          !_areDayTimesEqual(currentTimes, originalTimesPerDay) ||
                                          sessionsController.text != originalSessions;

                                  if (!hasChanged) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('يرجى تعديل حقل واحد على الأقل قبل الإرسال.')),
                                    );
                                    return;
                                  }
                                  Navigator.pop(context);

                                  widget.updateCubit.fetchUpdateSection(
                                    courseId: widget.section.id,
                                    name: nameController.text,
                                    seatsOfNumber: int.parse(seatsController.text),
                                    totalSessions: int.parse(sessionsController.text),
                                    startDate: startDateController.text,
                                    endDate: endDateController.text,
                                    sunday: {
                                      "start_time": sundayStartController.text,
                                      "end_time": sundayEndController.text,
                                    },
                                    monday: {
                                      "start_time": mondayStartController.text,
                                      "end_time": mondayEndController.text,
                                    },
                                    tuesday: {
                                      "start_time": tuesdayStartController.text,
                                      "end_time": tuesdayEndController.text,
                                    },
                                    wednesday: {
                                      "start_time": wednesdayStartController.text,
                                      "end_time": wednesdayEndController.text,
                                    },
                                    thursday: {
                                      "start_time": thursdayStartController.text,
                                      "end_time": thursdayEndController.text,
                                    },
                                    friday: {
                                      "start_time": fridayStartController.text,
                                      "end_time": fridayEndController.text,
                                    },
                                    saturday: {
                                      "start_time": saturdayStartController.text,
                                      "end_time": saturdayEndController.text,
                                    },
                                  );

                                  // تنظيف الحقول بعد الإرسال
                                  nameController.clear();
                                  seatsController.clear();
                                  statusController.clear();
                                  startDateController.clear();
                                  endDateController.clear();
                                  sundayStartController.clear();
                                  sundayEndController.clear();
                                  mondayStartController.clear();
                                  mondayEndController.clear();
                                  tuesdayStartController.clear();
                                  tuesdayEndController.clear();
                                  wednesdayStartController.clear();
                                  wednesdayEndController.clear();
                                  thursdayStartController.clear();
                                  thursdayEndController.clear();
                                  fridayStartController.clear();
                                  fridayEndController.clear();
                                  saturdayStartController.clear();
                                  saturdayEndController.clear();
                                  sessionsController.clear();
                                }
                            ),
                            SizedBox(width: 42.w,),
                            TextIconButton(
                              textButton: AppLocalizations.of(context).translate('       Cancel       '),
                              textColor: AppColors
                                  .t3,
                              iconLast: false,
                              buttonHeight: 53.h,
                              borderWidth: 0.w,
                              borderRadius: 4.r,
                              buttonColor: AppColors
                                  .w1,
                              borderColor: AppColors
                                  .w1,
                              onPressed: () {
                                nameController
                                    .clear();
                                seatsController
                                    .clear();
                                statusController
                                    .clear();
                                startDateController
                                    .clear();
                                endDateController
                                    .clear();
                                Navigator.pop(
                                    context);
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
      ),
    );
  }
}

//********************************************************************************************************

class UpdateStateDialog extends StatefulWidget {
  const UpdateStateDialog({super.key, required this.section, required this.updateCubit});

  final DatumInPreparation section;
  final UpdateStateSectionCubit updateCubit;

  @override
  State<UpdateStateDialog> createState() => _UpdateStateDialogState();
}

class _UpdateStateDialogState extends State<UpdateStateDialog> {

  late TextEditingController statusController;

  late final String originalState;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    originalState = widget.section.state;

    statusController = TextEditingController(text: widget.section.state);

    statusController = TextEditingController();
  }

  @override
  void dispose() {
    statusController.dispose();
    super.dispose();
  }

  final List<String> statusOptions = ['Pending', 'In progress', 'Finished',];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      SingleCheckboxCubit()..initializeSelectedItems(handleReceiveState(state: originalState)),
      child: BlocBuilder<SingleCheckboxCubit, SingleCheckboxState>(
        builder: (context, state) {
          String? selected = '';
          if (state is SingleCheckboxUpdated) {
            selected = state.selectedItem;
          }
          return Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 638.w,
                height: 478.h,
                margin: EdgeInsets.symmetric(
                    horizontal: 280
                        .w,
                    vertical: 255
                        .h),
                padding: EdgeInsets.all(22.r),
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
                        padding: EdgeInsets
                            .only(
                            top: 65
                                .h,
                            left: 60
                                .w,
                            right: 155
                                .w),
                        child: Text(
                          AppLocalizations.of(context).translate('Edit status'),
                          style: Styles
                              .h3Bold(
                              color: AppColors
                                  .t3),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets
                            .only(
                            top: 42
                                .h,
                            bottom: 68
                                .h,
                            left: 60
                                .w,
                            right: 55
                                .w),
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .max,
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Padding(
                              padding: EdgeInsets
                                  .only(
                                  left: 0
                                      .w,
                                  bottom: 22
                                      .h),
                              child: Text(
                                '',
                                style: Styles
                                    .l1Normal(
                                    color: AppColors
                                        .t2),
                                maxLines: 1,
                                overflow: TextOverflow
                                    .ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 728
                                  .w,
                              child: Wrap(
                                spacing: 70
                                    .w,
                                runSpacing: 8,
                                children: statusOptions
                                    .map((
                                    option) {
                                  final isSelected = selected ==
                                      option;
                                  return CustomCheckBox(
                                    isSelected: isSelected,
                                    option: option,
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 22
                                .h,
                            bottom: 65
                                .h,
                            left: 47
                                .w,
                            right: 155
                                .w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextIconButton(
                              textButton: AppLocalizations.of(context).translate('Edit status'),
                              bigText: true,
                              textColor: AppColors.t3,
                              icon: Icons.edit,
                              iconSize: 40.01.r,
                              iconColor: AppColors.t2,
                              iconLast: false,
                              firstSpaceBetween: 3.w,
                              buttonHeight: 53.h,
                              borderWidth: 0.w,
                              buttonColor: AppColors.white,
                              borderColor: Colors.transparent,
                              onPressed: () {
                                log(selected!);
                                statusController.text = selected;
                                Navigator.pop(context);
                                widget.updateCubit.fetchUpdateStateSection(
                                  courseId: widget.section.id,
                                  state: handleSendState(state: statusController.text),
                                );
                                statusController.clear();
                              },
                            ),
                            SizedBox(
                              width: 42
                                  .w,),
                            TextIconButton(
                              textButton: AppLocalizations.of(context).translate('       Cancel       '),
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
                                Navigator.pop(context);
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
      ),
    );
  }
}


extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

String formatTimeOfDay(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

class CustomStartEndTimePicker extends StatelessWidget {
  const CustomStartEndTimePicker({super.key, required this.dayName, required this.startTimeController, required this.endTimeController});

  final String dayName;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CustomLabelTextFormField(
            labelText: dayName,
            showLabelText: true,
            hintText: AppLocalizations.of(context).translate('Start time'),
            readOnly: true,
            controller: startTimeController,
            topPadding: 0
                .h,
            leftPadding: 0
                .w,
            rightPadding: 0
                .w,
            bottomPadding: 38
                .h,
            onTap: () async {
              TimeOfDay? time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                startTimeController.text = formatTimeOfDay(time);
              }
            },
          ),
        ),
        SizedBox(
          width: 13.w,),
        Expanded(
          flex: 1,
          child: CustomLabelTextFormField(
            labelText: '',
            showLabelText: true,
            hintText: AppLocalizations.of(context).translate('End time'),
            readOnly: true,
            controller: endTimeController,
            topPadding: 0
                .h,
            leftPadding: 0
                .w,
            rightPadding: 0
                .w,
            bottomPadding: 38
                .h,
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                final startParts = startTimeController.text.split(':');
                if (startParts.length == 2) {
                  final startHour = int.parse(startParts[0]);
                  final startMinute = int.parse(startParts[1]);

                  final startTime = TimeOfDay(hour: startHour, minute: startMinute);
                  final isEndAfterStart = pickedTime.hour > startTime.hour ||
                      (pickedTime.hour == startTime.hour &&
                          pickedTime.minute > startTime.minute);

                  if (!isEndAfterStart) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).translate('End time should be after start time!'))),);
                    return;
                  }

                  endTimeController.text =
                  '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context).translate('Please choose start time first!'))),
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}

double calculateWidthBetweenAvatars({required int avatarCount}) {
  double width = 495.w;
  if(avatarCount >= 1) {
    width = 496.w;
  }
  if(avatarCount >= 2) {
    width = 495.w;
  }
  if(avatarCount >= 3) {
    width = 498.w;
  }
  if(avatarCount >= 4) {
    width = 478.w;
  }
  if(avatarCount >= 5) {
    width = 445.w;
    //width = 270.w;
  }
  return width;
}

String handleReceiveState({required String state}) {
  if(state == 'pending') {
    return 'Pending';
  } else if(state == 'in_progress') {
    return 'In progress';
  } else if(state == 'finished') {
    return 'Finished';
  } else {
    return '';
  }
}

String handleSendState({required String state}) {
  if(state == 'Pending') {
    return 'pending';
  } else if(state == 'In progress') {
    return 'in_progress';
  } else if(state == 'Finished') {
    return 'finished';
  } else {
    return '';
  }
}