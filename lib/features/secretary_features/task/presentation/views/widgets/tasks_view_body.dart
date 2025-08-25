import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_check_box.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/presentation/manager/create_section_cubit/create_section_cubit.dart';
import '../../../../course/presentation/manager/create_section_cubit/create_section_state.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';
import '../../../data/models/tasks_model.dart';
import '../../manager/tasks_cubit/tasks_cubit.dart';
import '../../manager/tasks_cubit/tasks_state.dart';
import '../../manager/update_task_cubit/update_task_cubit.dart';
import '../../manager/update_task_cubit/update_task_state.dart';

class TasksViewBody extends StatelessWidget {
  const TasksViewBody({super.key});

  void _showFullTextDialog(BuildContext context, String bodyText1 , String bodyText2, String state, int id, /*, double? width, double? height, double? horizontal, double? vertical*/) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: /*Container(
                width: width ?? 638.w,
                height: height ?? 478.h,
                margin: EdgeInsets.symmetric(horizontal: horizontal ?? 280.w, vertical: vertical ?? 255.h),
                padding: EdgeInsets.all(22.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: */AlertDialog(
                  title: Text(
                    bodyText1,
                    style: Styles.h3Bold(color: AppColors.t3),
                  ),
                  scrollable: true,
                  backgroundColor: AppColors.white,
                  insetPadding: EdgeInsets.all(0),
                  content: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bodyText2,
                          style: Styles.b2Normal(color: AppColors.t1),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text("Close"),
                    ),
                  ],
                ),
              /*),*/
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateTaskCubit, UpdateTaskState>(
      listener: (contextU, stateU) {
        if (stateU is UpdateTaskFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateTaskStateFailure'),);
        } else if (stateU is UpdateTaskSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateTaskStateSuccess'),);
          TasksCubit.get(context).fetchTasks(page: 1);
        }
      },
      builder: (contextU, stateU) {
        return BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            if(state is TasksSuccess) {
              return Padding(
                padding: EdgeInsets.only(top: 56.0.h,),
                child: CustomScreenBody(
                  title: AppLocalizations.of(context).translate('Tasks'),
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
                          state.tasks.tasks.data!.isNotEmpty ? CustomListInformationFieldsTask(
                            secondField: AppLocalizations.of(context).translate('Created at'),
                            showSecondField: true,
                            widget: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return Align(child: InformationFieldItemTask(
                                  color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                  name: state.tasks.tasks.data![index].title,
                                  secondText: state.tasks.tasks.data![index].createdAt.toString().replaceRange(10, 24, ''),
                                  showSecondDetailsText: true,
                                  thirdDetailsText: state.tasks.tasks.data![index].description,
                                  fourthDetailsText: handleReceiveState(state: state.tasks.tasks.data![index].status),
                                  fourthDetailsTextColor: handleReceiveStateColor(state: state.tasks.tasks.data![index].status),
                                  showIcons: true,
                                  hideSecondIcon: true,
                                  onTap: () {
                                    _showFullTextDialog(context, state.tasks.tasks.data![index].title, state.tasks.tasks.data![index].description, state.tasks.tasks.data![index].status, state.tasks.tasks.data![index].id /*width, height, horizontal, vertical*/);
                                  },
                                  onTapFirstIcon: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return UpdateStateDialog(id: state.tasks.tasks.data![index].id ,status: state.tasks.tasks.data![index].status, updateCubit: context.read<UpdateTaskCubit>(),);
                                      },
                                    );
                                  },
                                  onTapSecondIcon: () {},
                                ));
                              },
                              itemCount: state.tasks.tasks.data!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ) : CustomEmptyWidget(
                            firstText: AppLocalizations.of(context).translate('No tasks at this time'),
                            secondText: AppLocalizations.of(context).translate('Tasks will appear here after they enroll in your institute.'),
                          ),
                          CustomNumberPagination(
                            numberPages: state.tasks.tasks.lastPage,
                            initialPage: state.tasks.tasks.currentPage,
                            onPageChange: (int index) {
                              context.read<TasksCubit>().fetchTasks(page: index + 1);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if(state is TasksFailure) {
              return CustomErrorWidget(errorMessage: state.errorMessage);
            } else {
              return CustomCircularProgressIndicator();
            }
          }
        );
      }
    );
  }
}

class CustomListInformationFieldsTask extends StatelessWidget {
  const CustomListInformationFieldsTask({super.key, required this.secondField, required this.widget, this.showSecondField, this.showFifthField, this.showSecondBox, this.showFirstBox});

  final String? secondField;
  final bool? showSecondField;
  final bool? showFifthField;
  final bool? showFirstBox;
  final bool? showSecondBox;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1151.24.w,
          height: 48.72.h,
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              showSecondBox ?? false ? SizedBox(width: 50.w,) : SizedBox(width: 0.w,),
              Expanded(
                //flex: 2,
                child: Text(
                  AppLocalizations.of(context).translate('Title'),
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 210.w : 145.w,) : SizedBox(width: showSecondBox ?? false ? 225.w : 175.w,),
              showSecondField ?? false ? Expanded(
                //flex: 2,
                child: Text(
                  secondField ?? '',
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ) : SizedBox(width: 0.w, height: 0.h,),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 80.w : 125.w,) : SizedBox(width: showSecondBox ?? false ? 110.w : 150.w,),
              //SizedBox(width: 50.w,),
              Expanded(
                flex: 2,
                child: Text(
                  AppLocalizations.of(context).translate('Description'),
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 110.w : 192.w,) : SizedBox(width: showSecondBox ?? false ? 182.w : 252.w,),
              //SizedBox(width: 220.w,),
              Expanded(
                //flex: showFifthField ?? false ? 1 : 2,
                //flex: 2,
                child: Text(
                  AppLocalizations.of(context).translate('State'),
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 80.w : 120.w,) : SizedBox(width: 0.w, height: 0.h,),
              //SizedBox(width: 220.w,),
              showFifthField ?? false ? Expanded(
                //flex: 3,
                //flex: 1,
                child: Text(
                  AppLocalizations.of(context).translate('Status'),
                  style: Styles.l2Medium(color: AppColors.t3),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ) : SizedBox(width: 0.w, height: 0.h,),
              showFifthField ?? false ? SizedBox(width: showFirstBox ?? false ? 180.w : 160.w,) : SizedBox(width: showSecondBox ?? false ? 215.w : 255.w,),
            ],
          ),
        ),
        widget,
      ],
    );
  }
}

class InformationFieldItemTask extends StatelessWidget {
  const InformationFieldItemTask({
    super.key, this.width, this.height, this.color, this.image, this.imageWidth, this.imageHeight, this.imageBorderRadius, this.widthProfileText, required this.name, this.nameColor, this.showDetailsText, this.secondText, this.secondTextColor, this.showSecondDetailsText, this.thirdDetailsText, this.thirdDetailsTextColor, this.showIcons, this.heightTextIcon, this.leftIcon, this.rightIcon, required this.onTap, this.fourthDetailsText, this.fourthDetailsTextColor, required this.onTapFirstIcon, required this.onTapSecondIcon, this.fifthText, this.fifthTextColor, this.showFifthDetailsText, this.showJustTowDetailsText, this.showFirstBox, this.hideFirstIcon, this.showSecondBox, this.hideSecondIcon, this.onTapFirstBox, this.onTapSecondBox, this.isReportStyle, this.hideFirstBox,
  });

  final double? width;
  final double? height;
  final Color? color;
  final String? image;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageBorderRadius;
  final double? widthProfileText;
  final String name;
  final Color? nameColor;
  final bool? showDetailsText;
  final String? secondText;
  final Color? secondTextColor;
  final bool? showSecondDetailsText;
  final String? thirdDetailsText;
  final Color? thirdDetailsTextColor;
  final String? fourthDetailsText;
  final Color? fourthDetailsTextColor;
  final String? fifthText;
  final Color? fifthTextColor;
  final bool? showFifthDetailsText;
  final bool? showJustTowDetailsText;
  final bool? showIcons;
  final bool? hideFirstIcon;
  final bool? hideSecondIcon;
  final double? heightTextIcon;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Function onTap;
  final Function onTapFirstIcon;
  final Function onTapSecondIcon;
  final Function? onTapFirstBox;
  final Function? onTapSecondBox;
  final bool? showFirstBox;
  final bool? hideFirstBox;
  final bool? showSecondBox;
  final bool? isReportStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(left: 7.0.w, right: 37.0.w),
        width: width ?? 1151.24.w,
        height: height ?? 66.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.white,
        ),
        child: isReportStyle ?? false ? Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  //Information
                  SizedBox(width: widthProfileText ?? 8.12.w,),
                  Expanded(
                    child: Text(
                      name,
                      style: Styles.l2Medium(color: nameColor ?? AppColors.t3),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              flex: 8,
              child: Text(
                secondText ?? '',
                style: Styles.l2Medium(color: secondTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 30.w,),
            Expanded(
              flex: 1,
              child: Text(
                fifthText ?? '',
                style: Styles.l2Medium(color: fifthTextColor ?? AppColors.darkLightPurple),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            //Action icons
            SizedBox(width: 20.0.h,),
            showIcons ?? false ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hideFirstIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: leftIcon ?? Icons.edit_outlined, onTap: (){onTapFirstIcon();},),
                SizedBox(width: 10.8.w,),
                hideSecondIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: rightIcon ?? Icons.delete_outline, onTap: (){onTapSecondIcon();},),
              ],
            ) : SizedBox(width: 0, height: 0,),
          ],
        ) : Row(
          children: [
            Expanded(
              flex: showFirstBox ?? false ? (showFifthDetailsText ?? false ? 2 : (showSecondBox ?? false ? 2 : 1)) : (hideFirstBox ?? false ? 2 : 1),
              child: Row(
                children: [
                  showFirstBox ?? false ? buildCheckOption(
                    borderColor: AppColors.t2,
                    icon: Icons.check,
                    iconColor: AppColors.t2,
                    isSelected: false,
                    onTap: (){onTapFirstBox!() ?? () {};},
                  ) : SizedBox(width: 0.w, height: 0.h,),
                  showSecondBox ?? false ? SizedBox(width: 8.w,) : SizedBox(width: 0.w, height: 0.h,),
                  showSecondBox ?? false ? buildCheckOption(
                    borderColor: AppColors.t2,
                    icon: Icons.close,
                    iconColor: AppColors.t2,
                    isSelected: false,
                    onTap: (){onTapFirstBox!() ?? () {};},
                  ) : SizedBox(width: 0.w, height: 0.h,),
                  showFirstBox ?? false ? SizedBox(width: showSecondBox ?? false ? 15.w : 10.w,) : SizedBox(width: 0.w, height: 0.h,),
                  //Information
                  SizedBox(width: widthProfileText ?? 8.12.w,),
                  Expanded(
                    child: Text(
                      name,
                      style: Styles.l2Medium(color: nameColor ?? AppColors.t3),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            showSecondDetailsText ?? false ? SizedBox(width: 80.w,) : SizedBox(width: 0.w, height: 0.h,),
            showSecondDetailsText ?? false ? Expanded(
              flex: 1,
              child: Text(
                secondText ?? '',
                style: Styles.l2Medium(color: secondTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ) : SizedBox(width: 0.w, height: 0.h,),
            SizedBox(width: 50.w,),
            Expanded(
              flex: showJustTowDetailsText ?? false ? 3 : 2,
              child: Text(
                thirdDetailsText ?? '',
                style: Styles.l2Medium(color: thirdDetailsTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 50.w,),
            Expanded(
              flex: 1,
              child: Text(
                fourthDetailsText ?? '',
                style: Styles.l2Medium(color: fourthDetailsTextColor ?? AppColors.t3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            showFifthDetailsText ?? false ? SizedBox(width: 50.w,) : SizedBox(width: 0.w, height: 0.h,),
            showFifthDetailsText ?? false ? Expanded(
              flex: 1,
              child: Text(
                fifthText ?? 'Complete',
                style: Styles.l2Medium(color: fifthTextColor ?? AppColors.mintGreen),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ) : SizedBox(width: 0.w, height: 0.h,),
            //Action icons
            SizedBox(width: 50.0.h,),
            showIcons ?? false ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                hideFirstIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: leftIcon ?? Icons.edit_outlined, onTap: (){onTapFirstIcon();},),
                SizedBox(width: 10.8.w,),
                hideSecondIcon ?? false ? SizedBox(width: 25.w, height: 0.h,) : CustomIconButton(icon: rightIcon ?? Icons.delete_outline, onTap: (){onTapSecondIcon();},),
              ],
            ) : SizedBox(width: 0, height: 0,),
            showIcons ?? false ? SizedBox(width: 0.w,) : SizedBox(width: showFifthDetailsText ?? false ? 0.w : 70.w),
          ],
        ),
      ),
    );
  }
}

class UpdateStateDialog extends StatefulWidget {
  const UpdateStateDialog({super.key, required this.id, required this.status, required this.updateCubit});

  final int id;
  final String status;
  final UpdateTaskCubit updateCubit;

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
    originalState = widget.status;

    statusController = TextEditingController(text: widget.status);

    statusController = TextEditingController();
  }

  @override
  void dispose() {
    statusController.dispose();
    super.dispose();
  }

  final List<String> statusOptions = ['Pending', 'In progress', 'Completed',];

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
                                widget.updateCubit.fetchUpdateTask(
                                  taskId: widget.id,
                                  state: statusController.text,
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

String handleReceiveState({required String state}) {
  if(state == 'pending') {
    return 'Pending';
  } else if(state == 'in_progress') {
    return 'In progress';
  } else if(state == 'completed') {
    return 'Completed';
  } else {
    return '';
  }
}

Color handleReceiveStateColor({required String state}) {
  if(state == 'pending') {
    return AppColors.t1;
  } else if(state == 'in_progress') {
    return AppColors.orange;
  } else if(state == 'completed') {
    return AppColors.mintGreen;
  } else {
    return Colors.black;
  }
}