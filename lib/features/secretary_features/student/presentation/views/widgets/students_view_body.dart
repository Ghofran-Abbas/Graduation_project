import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/core/widgets/custom_icon_button.dart';
import 'package:alhadara_dashboard/core/widgets/custom_image_network.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/models/students_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/data/repos/student_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/create_student_cubit/create_student_state.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/students_cubit/students_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/students_cubit/students_state.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/update_student_cubit/update_student_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/student/presentation/manager/update_student_cubit/update_student_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_dropdown_list.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/data/models/students_section_model.dart';
import '../../manager/create_student_cubit/create_student_cubit.dart';
import '../../manager/delete_student_cubit/delete_student_cubit.dart';
import '../../manager/delete_student_cubit/delete_student_state.dart';
import '../../manager/search_student_cubit/search_student_cubit.dart';
import '../../manager/search_student_cubit/search_student_state.dart';

class StudentsViewBody extends StatefulWidget {
  const StudentsViewBody({super.key});

  @override
  State<StudentsViewBody> createState() => _StudentsViewBodyState();
}

class _StudentsViewBodyState extends State<StudentsViewBody> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController birthDateController;
  late final TextEditingController genderController;
  late final TextEditingController passwordController;
  late final TextEditingController referredId;
  Uint8List? selectedImage;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    birthDateController = TextEditingController();
    genderController = TextEditingController();
    passwordController = TextEditingController();
    referredId = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    referredId.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          selectedImage = result.files.single.bytes!;
        });
      } else {
        CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('No image selected or image data is unavailable.'),);
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(context, msg: '${AppLocalizations.of(context).translate('Failed to pick image:')} $e',);
    }
  }

  void register() {
    if (_formKey.currentState!.validate() && selectedImage != null) {
      context.read<CreateStudentCubit>().fetchCreateStudent(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        birthday: birthDateController.text,
        gender: genderController.text,
        photo: selectedImage!,
        referredId: referredId.text != '' ? int.parse(referredId.text) : null,
      );
    } else {
      CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('Error, Please enter all the fields.'),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateStudentCubit, CreateStudentState>(
      listener: (context, state) {
        if (state is CreateStudentFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('CreateStudentFailure'),);
        } else if (state is CreateStudentSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('CreateStudentSuccess'),);
          StudentsCubit.get(context).fetchStudents(page: 1);
        } else if (state is ImagePickedSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('ImagePickedSuccess'),);
        }
      },
      builder: (context, state) {
        return BlocConsumer<UpdateStudentCubit, UpdateStudentState>(
          listener: (context, state) {
            if (state is UpdateStudentFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateStudentFailure'),);
            } else if (state is UpdateStudentSuccess) {
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateStudentSuccess'),);
              StudentsCubit.get(context).fetchStudents(page: 1);
            } else if (state is ImagePickedSuccess) {
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('ImagePickedSuccess'),);
            }
          },
          builder: (context, state) {
            return BlocConsumer<DeleteStudentCubit, DeleteStudentState>(
              listener: (context, state) {
                if (state is DeleteStudentFailure) {
                  CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteStudentFailure'),);
                } else if (state is DeleteStudentSuccess) {
                  CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteStudentSuccess'),);
                  StudentsCubit.get(context).fetchStudents(page: 1);
                }
              },
              builder: (context, state) {
                return BlocConsumer<StudentsCubit, StudentsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if(state is StudentsSuccess) {
                      return Padding(
                        padding: EdgeInsets.only(top: 56.0.h,),
                        child: CustomScreenBody(
                          title: AppLocalizations.of(context).translate('Students'),
                          showSearchField: true,
                          textSecondButton: AppLocalizations.of(context).translate('New student'),
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
                                                        AppLocalizations.of(context).translate('Add student'),
                                                        style: Styles.h3Bold(
                                                            color: AppColors.t3),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 45.h, left: 60.w),
                                                      child: Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              selectedImage != null
                                                                  ? CustomMemoryImage(
                                                                image: selectedImage,
                                                                imageWidth: 186.w,
                                                                imageHeight: 186.w,
                                                                borderRadius: 150.r,
                                                              )
                                                                  : CustomImageAsset(
                                                                imageWidth: 186.w,
                                                                imageHeight: 186.w,
                                                                borderRadius: 150.r,
                                                              ),
                                                              Positioned(
                                                                top: 140.w,
                                                                left: 150.w,
                                                                child: CustomIconButton(
                                                                  icon: Icons.add,
                                                                  onTap: () async {
                                                                    await pickImage();
                                                                    setStateDialog(() {});
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                CustomLabelTextFormField(
                                                                  labelText: AppLocalizations.of(context).translate('Full name'),
                                                                  showLabelText: true,
                                                                  controller: nameController,
                                                                  topPadding: 20.h,
                                                                  bottomPadding: 0.h,
                                                                  leftPadding: 175.w,
                                                                  rightPadding: 127.w,
                                                                  validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                                ),
                                                                CustomLabelTextFormField(
                                                                  labelText: AppLocalizations.of(context).translate('Email address'),
                                                                  showLabelText: true,
                                                                  controller: emailController,
                                                                  topPadding: 42.h,
                                                                  bottomPadding: 0.h,
                                                                  leftPadding: 175.w,
                                                                  rightPadding: 127.w,
                                                                  validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 60.w,
                                                                    right: 65.w),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child: CustomLabelTextFormField(
                                                                        hintText: AppLocalizations.of(context).translate('Birth date'),
                                                                        readOnly: true,
                                                                        controller: birthDateController,
                                                                        topPadding: 68.h,
                                                                        leftPadding: 0.w,
                                                                        rightPadding: 0.w,
                                                                        bottomPadding: 0
                                                                            .h,
                                                                        validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                                        onTap: () async {
                                                                          DateTime? pickedDate = await showDatePicker(
                                                                            context: context,
                                                                            initialDate: birthDateController
                                                                                .text
                                                                                .isEmpty
                                                                                ? DateTime
                                                                                .now()
                                                                                : DateTime
                                                                                .parse(
                                                                                birthDateController
                                                                                    .text),
                                                                            firstDate: DateTime(1980, 1, 1),
                                                                            lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                                                          );
                                                                          if (pickedDate !=
                                                                              null) {
                                                                            birthDateController
                                                                                .text =
                                                                            pickedDate
                                                                                .toString()
                                                                                .split(
                                                                                ' ')[0];
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 19.w,),
                                                                    Expanded(
                                                                      child: CustomDropdownList(
                                                                        hintText: AppLocalizations.of(context).translate('Gender'),
                                                                        statusController: genderController,
                                                                        topPadding: 68.h,
                                                                        bottomPadding: 0
                                                                            .h,
                                                                        dropdownMenuEntries: [
                                                                          DropdownMenuEntry(
                                                                            value: 'Female',
                                                                            label: AppLocalizations.of(context).translate('Female'),
                                                                          ),
                                                                          DropdownMenuEntry(
                                                                            value: 'Male',
                                                                            label: AppLocalizations.of(context).translate('Male'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: CustomLabelTextFormField(
                                                            labelText: AppLocalizations.of(context).translate('Password'),
                                                            showLabelText: true,
                                                            controller: passwordController,
                                                            topPadding: 42.h,
                                                            bottomPadding: 0.h,
                                                            leftPadding: 0.w,
                                                            rightPadding: 128.w,
                                                            validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 60.w,
                                                                    right: 65.w),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child: CustomLabelTextFormField(
                                                                        hintText: AppLocalizations.of(context).translate('Referred student'),
                                                                        readOnly: true,
                                                                        controller: referredId,
                                                                        topPadding: 68.h,
                                                                        leftPadding: 0.w,
                                                                        rightPadding: 0.w,
                                                                        bottomPadding: 0
                                                                            .h,
                                                                        validator: (value) {
                                                                          return null;
                                                                        },
                                                                        onTap: () async {
                                                                          final selectedStudent = await showDialog(
                                                                            context: context,
                                                                            builder: (_) => SelectReferrerStudent(),
                                                                          );

                                                                          if (selectedStudent != null) {
                                                                            print('الطالب المختار:  ${selectedStudent['id']} ${selectedStudent['name']}');
                                                                            referredId.text = selectedStudent['id'].toString();
                                                                            // استخدم selectedStudent['id'] كما تريد
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: CustomLabelTextFormField(
                                                            labelText: AppLocalizations.of(context).translate('Phone number'),
                                                            showLabelText: true,
                                                            controller: phoneController,
                                                            topPadding: 42.h,
                                                            bottomPadding: 0.h,
                                                            leftPadding: 0.w,
                                                            rightPadding: 128.w,
                                                            validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                          ),
                                                        ),
                                                      ],
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
                                                            textButton: AppLocalizations.of(context).translate('Add student'),
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
                                                              register();
                                                              if(_formKey.currentState!.validate() && selectedImage != null) {
                                                                Navigator.pop(dialogContext);
                                                                nameController.clear();
                                                                emailController.clear();
                                                                phoneController.clear();
                                                                birthDateController.clear();
                                                                genderController.clear();
                                                                passwordController.clear();
                                                              }
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
                                                            onPressed: () {
                                                              nameController.clear();
                                                              emailController.clear();
                                                              phoneController.clear();
                                                              birthDateController.clear();
                                                              genderController.clear();
                                                              passwordController.clear();
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
                          onTapSearch: () {
                            context.go(GoRouterPath.searchStudent);
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
                                  state.showResult.students.data!.isNotEmpty ? CustomListInformationFields(
                                    secondField: AppLocalizations.of(context).translate('Birth date'),
                                    showSecondField: true,
                                    widget: ListView.builder(
                                      itemBuilder: (BuildContext context, int index) {
                                        return Align(child: InformationFieldItem(
                                          color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                          image: state.showResult.students.data![index].photo,
                                          name: state.showResult.students.data![index].name,
                                          secondText: state.showResult.students.data![index].birthday.toString().replaceRange(10, 23, ''),
                                          showSecondDetailsText: true,
                                          thirdDetailsText: state.showResult.students.data![index].email,
                                          fourthDetailsText: state.showResult.students.data![index].gender,
                                          showIcons: true,
                                          onTap: () {
                                            context.go('${GoRouterPath.studentDetails}/${state.showResult.students.data![index].id}');
                                          },
                                          onTapFirstIcon: (){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext dialogContext) {
                                                return UpdateStudentDialog(student: state.showResult.students.data![index], updateCubit: context.read<UpdateStudentCubit>());
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
                                                                AppLocalizations.of(context).translate('Are you sure you want to delete this student?'),
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
                                                                      context.read<DeleteStudentCubit>().fetchDeleteStudent(id: state.showResult.students.data![index].id);
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
                                      itemCount: state.showResult.students.data!.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ) : CustomEmptyWidget(
                                    firstText: AppLocalizations.of(context).translate('No students at this time'),
                                    secondText: AppLocalizations.of(context).translate('Students will appear here after they enroll in your institute.'),
                                  ),
                                  CustomNumberPagination(
                                    numberPages: state.showResult.students.lastPage,
                                    initialPage: state.showResult.students.currentPage,
                                    onPageChange: (int index) {
                                      context.read<StudentsCubit>().fetchStudents(page: index + 1);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if(state is StudentsFailure) {
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
    );
  }
}

class UpdateStudentDialog extends StatefulWidget {
  const UpdateStudentDialog({super.key, required this.student, required this.updateCubit});

  final DatumStudent student;
  final UpdateStudentCubit updateCubit;

  @override
  State<UpdateStudentDialog> createState() => _UpdateStudentDialogState();
}

class _UpdateStudentDialogState extends State<UpdateStudentDialog> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController birthDateController;
  late final TextEditingController genderController;
  Uint8List? selectedImage;

  late final String originalName;
  late final String originalPhone;
  late final String originalBirthDate;
  late final String originalGender;
  late final String? originalImage;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    originalName = widget.student.name;
    originalPhone = widget.student.phone;
    originalBirthDate = widget.student.birthday.toString().replaceRange(10, 23, '');
    originalGender = widget.student.gender;
    originalImage = widget.student.photo;

    nameController = TextEditingController(text: originalName);
    phoneController = TextEditingController(text: originalPhone);
    birthDateController = TextEditingController(text: originalBirthDate);
    genderController = TextEditingController(text: originalGender);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true
      );
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          selectedImage = result.files.single.bytes!;
        });
      } else {
        CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('No image selected or image data is unavailable.'),);
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(context, msg: '${AppLocalizations.of(context).translate('Failed to pick image:')} $e',);
    }
  }

  void update(int id) {
    widget.updateCubit.fetchUpdateStudent(
      id: id,
      name: nameController.text,
      phone: phoneController.text,
      birthday: birthDateController.text,
      gender: genderController.text,
      photo: selectedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  height: 728.h,
                  margin: EdgeInsets.symmetric(
                      horizontal: 160.w, vertical: 160.h),
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
                          padding: EdgeInsets.only(top: 65.h,
                              left: 60.w,
                              right: 155.w),
                          child: Text(
                            AppLocalizations.of(context).translate('Edit student'),
                            style: Styles.h3Bold(
                                color: AppColors.t3),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 60.w),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  originalImage != null ? selectedImage != null ? CustomMemoryImage(
                                    image: selectedImage,
                                    imageWidth: 186.w,
                                    imageHeight: 186.w,
                                    borderRadius: 150.r,
                                  ) : SizedBox(
                                    width: 186.w,
                                    height: 186.w,
                                    child: CustomImageNetwork(
                                      imageWidth: 186.w,
                                      imageHeight: 186.w,
                                      borderRadius: 150.r,
                                      image: widget.student.photo,
                                    ),
                                  ) : selectedImage != null ? CustomMemoryImage(
                                    image: selectedImage,
                                    imageWidth: 186.w,
                                    imageHeight: 186.w,
                                    borderRadius: 150.r,
                                  ) : CustomImageAsset(
                                    imageWidth: 186.w,
                                    imageHeight: 186.w,
                                    borderRadius: 150.r,
                                  ),
                                  Positioned(
                                    top: 140.w,
                                    left: 150.w,
                                    child: CustomIconButton(
                                      icon: Icons.add,
                                      onTap: () async {
                                        await pickImage();
                                        setStateDialog(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomLabelTextFormField(
                                      labelText: AppLocalizations.of(context).translate('Full name'),
                                      showLabelText: true,
                                      controller: nameController,
                                      topPadding: 20.h,
                                      bottomPadding: 0.h,
                                      leftPadding: 165.w,
                                      rightPadding: 137.w,
                                    ),
                                    CustomLabelTextFormField(
                                      labelText: AppLocalizations.of(context).translate('Phone number'),
                                      showLabelText: true,
                                      controller: phoneController,
                                      topPadding: 42.h,
                                      bottomPadding: 0.h,
                                      leftPadding: 165.w,
                                      rightPadding: 137.w,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Expanded(
                                          child: CustomLabelTextFormField(
                                            hintText: AppLocalizations.of(context).translate('Birth date'),
                                            readOnly: true,
                                            controller: birthDateController,
                                            topPadding: 72.h,
                                            leftPadding: 165.w,
                                            rightPadding: 0.w,
                                            bottomPadding: 0.h,
                                            onTap: () async {
                                              DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: birthDateController.text.isEmpty ? DateTime.now() : DateTime.parse(birthDateController.text),
                                                firstDate: DateTime(1980, 1, 1),
                                                lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                                              );
                                              if (pickedDate !=
                                                  null) {
                                                birthDateController
                                                    .text =
                                                pickedDate
                                                    .toString()
                                                    .split(
                                                    ' ')[0];
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 19.w,),
                                        Expanded(
                                          child: CustomDropdownList(
                                            hintText: AppLocalizations.of(context).translate('Gender'),
                                            statusController: genderController,
                                            topPadding: 72.h,
                                            bottomPadding: 0.h,
                                            dropdownMenuEntries: [
                                              DropdownMenuEntry(
                                                value: 'Female',
                                                label: AppLocalizations.of(context).translate('Female'),
                                              ),
                                              DropdownMenuEntry(
                                                value: 'Male',
                                                label: AppLocalizations.of(context).translate('Male'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextIconButton(
                                textButton: AppLocalizations.of(context).translate('Edit student'),
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
                                  final hasChanged =
                                      nameController.text != originalName ||
                                          phoneController.text != originalPhone ||
                                              birthDateController.text != originalBirthDate ||
                                                  genderController.text != originalGender ||
                                                      selectedImage != null;

                                  if (!hasChanged) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('يرجى تعديل حقل واحد على الأقل قبل الإرسال.')),
                                    );
                                    return;
                                  }
                                  update(widget.student.id);
                                  nameController.clear();
                                  phoneController.clear();
                                  birthDateController.clear();
                                  genderController.clear();
                                  Navigator.pop(context);
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
                                onPressed: () {
                                  nameController.clear();
                                  phoneController.clear();
                                  birthDateController.clear();
                                  genderController.clear();
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
            ),
          );
        }
    );
  }
}

class SelectReferrerStudent extends StatelessWidget {
  SelectReferrerStudent({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SearchStudentCubit(
          getIt.get<StudentRepoImpl>(),
        );
      },
      child: StatefulBuilder(
        builder: (context, setState) {
          return Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 1171.w,
                height: 858.h,
                margin: EdgeInsets.symmetric(
                    horizontal: 10.w, vertical: 85.h),
                padding: EdgeInsets.only(top: 40.r, bottom: 10.h, left: 35.w, right: 35.w,),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 20.h),
                    CustomTextFormField(
                      hintText: AppLocalizations.of(context).translate('Search here...'),
                      hintTextStyle: Styles.l2Medium(color: AppColors.t1),
                      borderRadius: 4.r,
                      borderColor: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 19.73.w),
                      filled: true,
                      fillColor: AppColors.highlightPurple,
                      prefixIcon: Icons.search_outlined,
                      prefixSize: 19.73.r,
                      controller: searchController,
                      onTap: () {},
                      onPressed: () {},
                      onFieldSubmitted: (value) {
                        context.read<SearchStudentCubit>().fetchSearchStudent(
                          querySearch: searchController.text,
                          page: 1,
                        );
                      },
                    ),
                    SizedBox(height: 40.h),
                    BlocBuilder<SearchStudentCubit, SearchStudentState>(
                      builder: (context, state) {
                        if (state is SearchStudentSuccess) {
                          final students = state.student.students.data!;
                          return SizedBox(
                            height: 688.h,
                            child: Column(
                              children: [
                                Expanded(
                                  child: students.isNotEmpty
                                      ? ListView.builder(
                                    itemCount: students.length,
                                    itemBuilder: (context, index) {
                                      final student = students[index];
                                      return InformationFieldItem(
                                        color: index.isEven
                                            ? AppColors.white
                                            : AppColors.darkHighlightPurple,
                                        image: student.photo,
                                        name: student.name,
                                        secondText: student.birthday.toString().replaceRange(10, 23, ''),
                                        showSecondDetailsText: true,
                                        thirdDetailsText: student.email,
                                        fourthDetailsText: student.gender,
                                        showFirstBox: true,
                                        showIcons: false,
                                        hideFirstIcon: true,
                                        hideSecondIcon: true,
                                        onTapFirstBox: () {
                                          Navigator.pop(context, {
                                            'id': student.id,
                                            'name': student.name,
                                          });
                                        },
                                        onTapFirstIcon: (){},
                                        onTapSecondIcon: (){},
                                        onTap: (){},
                                      );
                                    },
                                  )
                                      : Center(
                                    child: CustomErrorWidget(
                                      errorMessage: AppLocalizations.of(context).translate('No thing to display'),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                CustomNumberPagination(
                                  numberPages: state.student.students.lastPage,
                                  initialPage: state.student.students.currentPage,
                                  onPageChange: (index) {
                                    context.read<SearchStudentCubit>().fetchSearchStudent(
                                      querySearch: searchController.text,
                                      page: index + 1,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else if (state is SearchStudentFailure) {
                          return CustomErrorWidget(errorMessage: state.errorMessage);
                        } else if (state is SearchStudentLoading) {
                          return Center(child: CustomCircularProgressIndicator());
                        } else {
                          return Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('Search to see more')));
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
