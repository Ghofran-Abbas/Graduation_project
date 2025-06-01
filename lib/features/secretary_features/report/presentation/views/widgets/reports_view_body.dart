import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/features/secretary_features/report/presentation/manager/create_report_cubit/create_report_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/presentation/manager/create_report_cubit/create_report_state.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/presentation/manager/reports_cubit/reports_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/presentation/manager/reports_cubit/reports_state.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/presentation/manager/update_report_cubit/update_report_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/presentation/manager/update_report_cubit/update_report_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../data/models/reports_model.dart';

class ReportsViewBody extends StatefulWidget {
  const ReportsViewBody({super.key});

  @override
  State<ReportsViewBody> createState() => _ReportsViewBodyState();
}

class _ReportsViewBodyState extends State<ReportsViewBody> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  Uint8List? selectedFile;
  String? name;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf', 'doc', 'docx', 'xls', 'xlsx'],
          withData: true
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          selectedFile = result.files.single.bytes!;
          name = result.files.single.name;
        });
      } else {
        CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('No image selected or image data is unavailable.'),);
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(context, msg: '${AppLocalizations.of(context).translate('Failed to pick image:')} $e',);
    }
  }

  void register(BuildContext contextS) {
    if (_formKey.currentState!.validate() && selectedFile != null) {
      context.read<CreateReportCubit>().fetchCreateReport(
        name: titleController.text,
        description: descriptionController.text,
        fileName: name!,
        file: selectedFile!,
      );
      //Navigator.pop(contextS);
    } else {
      //Navigator.pop(contextS);
      CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('Error, Please enter all the fields.'),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateReportCubit, CreateReportState>(
      listener: (context, state) {
        if (state is CreateReportFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('CreateReportFailure'),);
        } else if (state is CreateReportSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('CreateReportSuccess'),);
          ReportsCubit.get(context).fetchReports(page: 1);
        }
      },
      builder: (context, state) {
        return BlocConsumer<UpdateReportCubit, UpdateReportState>(
          listener: (context, state) {
            if (state is UpdateReportFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateReportFailure'),);
            } else if (state is UpdateReportSuccess) {
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateReportSuccess'),);
              ReportsCubit.get(context).fetchReports(page: 1);
            }
          },
          builder: (context, state) {
            return BlocBuilder<ReportsCubit, ReportsState>(
              builder: (context, state) {
                if(state is ReportsSuccess) {
                  return Padding(
                    padding: EdgeInsets.only(top: 56.0.h,),
                    child: CustomScreenBody(
                      title: AppLocalizations.of(context).translate('Reports'),
                      textSecondButton: AppLocalizations.of(context).translate('New report'),
                      showSecondButton: true,
                      onPressedFirst: () {},
                      onPressedSecond: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setStateDialog) {
                                  return Form(
                                    key: _formKey,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          width: 871.w,
                                          height: 858.h,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 160.w, vertical: 85.h),
                                          padding: EdgeInsets.all(22.r),
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(6.r),
                                          ),
                                          child: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(top: 65.h,
                                                      left: 60.w,
                                                      right: 155.w),
                                                  child: Text(
                                                    AppLocalizations
                                                        .of(context)
                                                        .translate('Add report'),
                                                    style: Styles.h3Bold(
                                                        color: AppColors.t3),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 60.w),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: 60.h,
                                                                  bottom: 0.h,
                                                                  left: 0.w,
                                                                  right: 127.w),
                                                              child: CustomFilePickerField(
                                                                hintText: '(.png, .jpg, .pdf, .doc, .docx, .xls, .xlsx ,*)',
                                                                fileName: name,
                                                                pickFile: () async {
                                                                  await pickImage();
                                                                  setStateDialog(() {});
                                                                },
                                                              ),
                                                            ),
                                                            CustomLabelTextFormField(
                                                              labelText: AppLocalizations
                                                                  .of(context)
                                                                  .translate('Title'),
                                                              showLabelText: true,
                                                              controller: titleController,
                                                              topPadding: 42.h,
                                                              bottomPadding: 0.h,
                                                              leftPadding: 0.w,
                                                              rightPadding: 127.w,
                                                              validator: (value) =>
                                                              value!.isEmpty
                                                                  ? AppLocalizations.of(
                                                                  context).translate(
                                                                  'This field required')
                                                                  : null,
                                                            ),
                                                            CustomLabelTextFormField(
                                                              labelText: AppLocalizations
                                                                  .of(context)
                                                                  .translate(
                                                                  'Description'),
                                                              showLabelText: true,
                                                              controller: descriptionController,
                                                              boxHeight: 360.h,
                                                              maxLines: 11,
                                                              topPadding: 35.h,
                                                              bottomPadding: 0.h,
                                                              leftPadding: 0.w,
                                                              rightPadding: 128.w,
                                                              validator: (value) =>
                                                              value!.isEmpty
                                                                  ? AppLocalizations.of(
                                                                  context).translate(
                                                                  'This field required')
                                                                  : null,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 60.h,
                                                      bottom: 65.h,
                                                      left: 47.w,
                                                      right: 155.w),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: [
                                                      TextIconButton(
                                                        textButton: AppLocalizations.of(
                                                            context).translate(
                                                            'Add report'),
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
                                                        borderColor: Colors
                                                            .transparent,
                                                        onPressed: () {
                                                          register(dialogContext);
                                                          if(_formKey.currentState!.validate() && selectedFile != null) {
                                                            titleController.clear();
                                                            descriptionController.clear();
                                                            Navigator.pop(dialogContext);
                                                          }
                                                        },
                                                      ),
                                                      SizedBox(width: 42.w,),
                                                      TextIconButton(
                                                        textButton: AppLocalizations.of(
                                                            context).translate(
                                                            '       Cancel       '),
                                                        textColor: AppColors.t3,
                                                        iconLast: false,
                                                        buttonHeight: 53.h,
                                                        borderWidth: 0.w,
                                                        borderRadius: 4.r,
                                                        buttonColor: AppColors.w1,
                                                        borderColor: AppColors.w1,
                                                        onPressed: () {
                                                          titleController.clear();
                                                          descriptionController.clear();
                                                          Navigator.pop(
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
                                    ),
                                  );
                                }
                            );
                          },
                        );
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
                              state.reports.reports.data!.isNotEmpty ? ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return Align(child: InformationFieldItem(
                                    color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                    image: state.reports.reports.data![index].secretary.photo,
                                    name: state.reports.reports.data![index].secretary.name,
                                    secondText: state.reports.reports.data![index].description,
                                    showSecondDetailsText: true,
                                    fifthText: handleDate(state.reports.reports.data![index].createdAt),
                                    showFifthDetailsText: true,
                                    isReportStyle: true,
                                    showIcons: true,
                                    hideSecondIcon: true,
                                    onTap: () {
                                      context.go('${GoRouterPath.reports}${GoRouterPath.detailsReport}/${state.reports.reports.data![index].id}');
                                    },
                                    onTapFirstIcon: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return UpdateReportDialog(report: state.reports.reports.data![index], updateCubit: context.read<UpdateReportCubit>());
                                        },
                                      );
                                    },
                                    onTapSecondIcon: () {
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
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 280.w, vertical: 255.h),
                                                padding: EdgeInsets.all(22.r),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius.circular(
                                                      6.r),
                                                ),
                                                child: SingleChildScrollView(
                                                  physics: BouncingScrollPhysics(),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 65
                                                            .h, left: 30.w, right: 155
                                                            .w),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.error_outline,
                                                              color: AppColors.orange,
                                                              size: 55.r,
                                                            ),
                                                            SizedBox(width: 10.w,),
                                                            Text(
                                                              AppLocalizations.of(
                                                                  context).translate(
                                                                  'Warning'),
                                                              style: Styles.h3Bold(
                                                                  color: AppColors.t3),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 75
                                                            .h, left: 65.w, right: 155
                                                            .w),
                                                        child: Text(
                                                          AppLocalizations
                                                              .of(context)
                                                              .translate(
                                                              'Are you sure you want to delete this student?'),
                                                          style: Styles.b2Normal(
                                                              color: AppColors.t3),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 90
                                                            .h, bottom: 65.h, left: 47
                                                            .w, right: 155.w),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            TextIconButton(
                                                              textButton: AppLocalizations
                                                                  .of(context)
                                                                  .translate('Confirm'),
                                                              bigText: true,
                                                              textColor: AppColors.t3,
                                                              icon: Icons
                                                                  .check_circle_outline,
                                                              iconSize: 40.01.r,
                                                              iconColor: AppColors.t2,
                                                              iconLast: false,
                                                              firstSpaceBetween: 3.w,
                                                              buttonHeight: 53.h,
                                                              borderWidth: 0.w,
                                                              buttonColor: AppColors
                                                                  .white,
                                                              borderColor: Colors
                                                                  .transparent,
                                                              onPressed: () {
                                                                //context.read<DeleteStudentCubit>().fetchDeleteStudent(id: state.showResult.students.data![index].id);
                                                                Navigator.pop(
                                                                    dialogContext);
                                                              },
                                                            ),
                                                            SizedBox(width: 42.w,),
                                                            TextIconButton(
                                                              textButton: AppLocalizations
                                                                  .of(context)
                                                                  .translate(
                                                                  '       Cancel       '),
                                                              textColor: AppColors.t3,
                                                              iconLast: false,
                                                              buttonHeight: 53.h,
                                                              borderWidth: 0.w,
                                                              borderRadius: 4.r,
                                                              buttonColor: AppColors.w1,
                                                              borderColor: AppColors.w1,
                                                              onPressed: () {
                                                                Navigator.pop(
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
                                itemCount: state.reports.reports.data!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              ) : CustomEmptyWidget(
                                firstText: AppLocalizations.of(context).translate('No reports at this time'),
                                secondText: AppLocalizations.of(context).translate('Reports will appear here after they enroll in your institute.'),
                              ),
                              CustomNumberPagination(
                                numberPages: state.reports.reports.lastPage,
                                initialPage: state.reports.reports.currentPage,
                                onPageChange: (int index) {
                                  context.read<ReportsCubit>().fetchReports(page: index + 1);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if(state is ReportsFailure) {
                  return CustomErrorWidget(errorMessage: state.errorMessage);
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

class UpdateReportDialog extends StatefulWidget {
  const UpdateReportDialog({super.key, required this.report, required this.updateCubit});

  final DatumReport report;
  final UpdateReportCubit updateCubit;

  @override
  State<UpdateReportDialog> createState() => _UpdateReportDialogState();
}

class _UpdateReportDialogState extends State<UpdateReportDialog> {

  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  Uint8List? selectedFile;
  String? name;

  late final String originalTitle;
  late final String originalDescription;
  late final String originalBirthDate;
  late final String originalGender;
  late final String? originalImage;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    originalTitle = widget.report.name;
    originalDescription = widget.report.description;

    titleController = TextEditingController(text: originalTitle);
    descriptionController = TextEditingController(text: originalDescription);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf', 'doc', 'docx', 'xls', 'xlsx'],
          withData: true
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          selectedFile = result.files.single.bytes!;
          name = result.files.single.name;
        });
      } else {
        CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('No image selected or image data is unavailable.'),);
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(context, msg: '${AppLocalizations.of(context).translate('Failed to pick image:')} $e',);
    }
  }

  void update(int id) {
    widget.updateCubit.fetchUpdateReport(
      id: id,
      name: titleController.text,
      description: descriptionController.text,
      fileName: name,
      file: selectedFile,
    );
    //Navigator.pop(contextS);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context,
            void Function(void Function()) setStateDialog) {
          return Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 871.w,
                height: 858.h,
                margin: EdgeInsets.symmetric(
                    horizontal: 160.w, vertical: 85.h),
                padding: EdgeInsets.all(22.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 65.h,
                            left: 60.w,
                            right: 155.w),
                        child: Text(
                          AppLocalizations
                              .of(context)
                              .translate('Edit report'),
                          style: Styles.h3Bold(
                              color: AppColors.t3),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 60.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 60.h,
                                        bottom: 0.h,
                                        left: 0.w,
                                        right: 127.w),
                                    child: CustomFilePickerField(
                                      hintText: '(.png, .jpg, .pdf, .doc, .docx, .xls, .xlsx ,*)',
                                      fileName: name,
                                      pickFile: () async {
                                        await pickImage();
                                        setStateDialog(() {});
                                      },
                                    ),
                                  ),
                                  CustomLabelTextFormField(
                                    labelText: AppLocalizations
                                        .of(context)
                                        .translate('Title'),
                                    showLabelText: true,
                                    controller: titleController,
                                    topPadding: 42.h,
                                    bottomPadding: 0.h,
                                    leftPadding: 0.w,
                                    rightPadding: 127.w,
                                    validator: (value) =>
                                    value!.isEmpty
                                        ? AppLocalizations.of(
                                        context).translate(
                                        'This field required')
                                        : null,
                                  ),
                                  CustomLabelTextFormField(
                                    labelText: AppLocalizations
                                        .of(context)
                                        .translate(
                                        'Description'),
                                    showLabelText: true,
                                    controller: descriptionController,
                                    boxHeight: 360.h,
                                    maxLines: 11,
                                    topPadding: 35.h,
                                    bottomPadding: 0.h,
                                    leftPadding: 0.w,
                                    rightPadding: 128.w,
                                    validator: (value) =>
                                    value!.isEmpty
                                        ? AppLocalizations.of(
                                        context).translate(
                                        'This field required')
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.h,
                            bottom: 65.h,
                            left: 47.w,
                            right: 155.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start,
                          children: [
                            TextIconButton(
                              textButton: AppLocalizations.of(
                                  context).translate(
                                  'Edit report'),
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
                              borderColor: Colors
                                  .transparent,
                              onPressed: () {
                                update(widget.report.id);
                                titleController.clear();
                                descriptionController.clear();
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(width: 42.w,),
                            TextIconButton(
                              textButton: AppLocalizations.of(
                                  context).translate(
                                  '       Cancel       '),
                              textColor: AppColors.t3,
                              iconLast: false,
                              buttonHeight: 53.h,
                              borderWidth: 0.w,
                              borderRadius: 4.r,
                              buttonColor: AppColors.w1,
                              borderColor: AppColors.w1,
                              onPressed: () {
                                titleController.clear();
                                descriptionController.clear();
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
        }
    );
  }
}


String handleDate(DateTime date) {
  log(DateTime(date.year, date.month, date.day, date.add(Duration(hours: 3)).hour, date.minute).toString());
  log(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute).toString());
  log('message');


  if(DateTime(date.year, date.month, date.day).isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration(days: -1)))) {

    return '${date.year}-${date.month}-${date.day}';

  } else if(DateTime(date.year, date.month, date.day).isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration(days: -1)))) {

    return 'Yesterday';

  } else if(DateTime(date.year, date.month, date.day, date.add(Duration(hours: 3)).hour, date.minute).isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute))) {

    return 'Now';

  } else if(DateTime(date.year, date.month, date.day).isAtSameMomentAs(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {

    return '${date.add(Duration(hours: 3)).hour}:${date.minute}';

  } else {

    return 'No Time';

  }
}