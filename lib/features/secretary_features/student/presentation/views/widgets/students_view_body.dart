import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/core/widgets/custom_icon_button.dart';
import 'package:alhadara_dashboard/core/widgets/custom_image_network.dart';
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

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_dropdown_list.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../manager/create_student_cubit/create_student_cubit.dart';
import '../../manager/delete_student_cubit/delete_student_cubit.dart';
import '../../manager/delete_student_cubit/delete_student_state.dart';

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
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      log('message 1');
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true
      );
      log('message 2');
      if (result != null && result.files.single.bytes != null) {
        log('message 3');
        setState(() {
          selectedImage = result.files.single.bytes!;
        });
        log('message 4');
      } else {
        log('No image selected or image data is unavailable.');
      }
    } catch (e) {
      log('Failed to pick image: $e');
    }
  }

  void register() {
    if (selectedImage != null) {
      context.read<CreateStudentCubit>().fetchCreateStudent(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        birthday: birthDateController.text,
        photo: selectedImage!,
      );
    } else {
      CustomSnackBar.showErrorSnackBar(context, msg: 'AppLocalizations.of(context).translate('')',);
    }
  }

  void update(int id) {
    context.read<UpdateStudentCubit>().fetchUpdateStudent(
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
    return BlocConsumer<CreateStudentCubit, CreateStudentState>(
      listener: (context, state) {
        if (state is CreateStudentFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('CreateStudentFailure'),);
        } else if (state is CreateStudentSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('CreateStudentSuccess'),);
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
                } else if (state is ImagePickedSuccess) {
                  CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('ImagePickedSuccess'),);
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
                          title: 'Students',
                          showSearchField: true,
                          textSecondButton: 'New student',
                          showSecondButton: true,
                          onPressedFirst: () {},
                          onPressedSecond: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
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
                                                      'Add student',
                                                      style: Styles.h3Bold(
                                                          color: AppColors.t3),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 60.w),
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
                                                                labelText: 'Full name',
                                                                showLabelText: true,
                                                                controller: nameController,
                                                                topPadding: 20.h,
                                                                bottomPadding: 0.h,
                                                                leftPadding: 175.w,
                                                                rightPadding: 127.w,
                                                              ),
                                                              CustomLabelTextFormField(
                                                                labelText: 'Email address',
                                                                showLabelText: true,
                                                                controller: emailController,
                                                                topPadding: 42.h,
                                                                bottomPadding: 0.h,
                                                                leftPadding: 175.w,
                                                                rightPadding: 127.w,
                                                              ),
                                                              CustomLabelTextFormField(
                                                                labelText: 'Password',
                                                                showLabelText: true,
                                                                controller: passwordController,
                                                                topPadding: 42.h,
                                                                bottomPadding: 0.h,
                                                                leftPadding: 175.w,
                                                                rightPadding: 127.w,
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
                                                                      hintText: 'Birth date',
                                                                      readOnly: true,
                                                                      controller: birthDateController,
                                                                      topPadding: 68.h,
                                                                      leftPadding: 0.w,
                                                                      rightPadding: 0.w,
                                                                      bottomPadding: 0
                                                                          .h,
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
                                                                          firstDate: DateTime(
                                                                              2000),
                                                                          lastDate: DateTime(
                                                                              2100),
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
                                                                      hintText: 'Gender',
                                                                      statusController: genderController,
                                                                      topPadding: 68.h,
                                                                      bottomPadding: 0
                                                                          .h,
                                                                      dropdownMenuEntries: [
                                                                        DropdownMenuEntry(
                                                                          value: 'Female',
                                                                          label: 'Female',
                                                                        ),
                                                                        DropdownMenuEntry(
                                                                          value: 'Male',
                                                                          label: 'Male',
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
                                                          labelText: 'Phone number',
                                                          showLabelText: true,
                                                          controller: phoneController,
                                                          topPadding: 42.h,
                                                          bottomPadding: 0.h,
                                                          leftPadding: 0.w,
                                                          rightPadding: 128.w,
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
                                                          textButton: 'Add student',
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
                                                        SizedBox(width: 42.w,),
                                                        TextIconButton(
                                                          textButton: '       Cancel       ',
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
                                      );
                                    }
                                );
                              },
                            );
                          },
                          body: state.showResult.students.data != null ? Padding(
                            padding: EdgeInsets.only(top: 238.0.h,
                                left: 20.0.w,
                                right: 20.0.w,
                                bottom: 27.0.h),
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: CustomListInformationFields(
                                secondField: 'Points',
                                widget: ListView.builder(
                                  itemBuilder: (BuildContext context, int index) {
                                    return Align(child: InformationFieldItem(
                                      color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                      image: state.showResult.students.data![index].photo,
                                      name: state.showResult.students.data![index].name,
                                      secondText: '150',
                                      thirdDetailsText: state.showResult.students.data![index].email,
                                      fourthDetailsText: 'Female',
                                      showIcons: true,
                                      onTap: () {
                                        context.go('${GoRouterPath.studentDetails}/${state.showResult.students.data![index].id}');
                                      },
                                      onTapFirstIcon: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext dialogContext) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  void Function(void Function()) setStateDialog) {
                                                return Align(
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
                                                                'Edit student',
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
                                                                          labelText: 'Full name',
                                                                          showLabelText: true,
                                                                          controller: nameController,
                                                                          topPadding: 20.h,
                                                                          bottomPadding: 0.h,
                                                                          leftPadding: 165.w,
                                                                          rightPadding: 137.w,
                                                                        ),
                                                                        CustomLabelTextFormField(
                                                                          labelText: 'Phone number',
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
                                                                                hintText: 'Birth date',
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
                                                                                    firstDate: DateTime(2000),
                                                                                    lastDate: DateTime(2100),
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
                                                                                hintText: 'Gender',
                                                                                statusController: genderController,
                                                                                topPadding: 72.h,
                                                                                bottomPadding: 0.h,
                                                                                dropdownMenuEntries: [
                                                                                  DropdownMenuEntry(
                                                                                    value: 'Female',
                                                                                    label: 'Female',
                                                                                  ),
                                                                                  DropdownMenuEntry(
                                                                                    value: 'Male',
                                                                                    label: 'Male',
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
                                                                    textButton: 'Edit student',
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
                                                                      update(state.showResult.students.data![index].id);
                                                                      nameController.clear();
                                                                      emailController.clear();
                                                                      phoneController.clear();
                                                                      birthDateController.clear();
                                                                      genderController.clear();
                                                                      passwordController.clear();
                                                                      Navigator.pop(dialogContext);
                                                                    },
                                                                  ),
                                                                  SizedBox(width: 42.w,),
                                                                  TextIconButton(
                                                                    textButton: '       Cancel       ',
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
                                              }
                                            );
                                          },
                                        );
                                      },
                                      onTapSecondIcon: (){
                                        {
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
                                                                  'Warning',
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
                                                                  textButton: 'Confirm',
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
                                                                  textButton: '       Cancel       ',
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
                                        }
                                      },
                                    ));
                                  },
                                  itemCount: state.showResult.students.data!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                ),
                              ),
                            ),
                          ) : Center(child: CustomErrorWidget(errorMessage: 'No thing to display')),
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
