import 'dart:developer';
import 'dart:typed_data';

import 'package:alhadara_dashboard/core/widgets/custom_circular_progress_indicator.dart';
import 'package:alhadara_dashboard/core/widgets/custom_error_widget.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/models/trainers_model.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/create_trainer_cubit/create_trainer_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/create_trainer_cubit/create_trainer_state.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/delete_trainer_cubit/delete_trainer_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/delete_trainer_cubit/delete_trainer_state.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/trainers_cubit/trainers_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/trainers_cubit/trainers_state.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/update_trainer_cubit/update_trainer_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/update_trainer_cubit/update_trainer_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_image_network.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_dropdown_list.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_label_text_form_field.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';

class TrainersViewBody extends StatefulWidget {
  const TrainersViewBody({super.key});

  @override
  State<TrainersViewBody> createState() => _TrainersViewBodyState();
}

class _TrainersViewBodyState extends State<TrainersViewBody> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController birthDateController;
  late final TextEditingController genderController;
  late final TextEditingController passwordController;
  late final TextEditingController specificationController;
  late final TextEditingController experienceController;
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
    specificationController = TextEditingController();
    experienceController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    birthDateController.dispose();
    genderController.dispose();
    specificationController.dispose();
    experienceController.dispose();
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
        CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('No image selected or image data is unavailable.'),);
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(context, msg: '${AppLocalizations.of(context).translate('Failed to pick image:')} $e',);
    }
  }

  void register() {
    if (_formKey.currentState!.validate() && selectedImage != null) {
      context.read<CreateTrainerCubit>().fetchCreateTrainer(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        birthday: birthDateController.text,
        photo: selectedImage!,
        gender: genderController.text,
        specialization: specificationController.text,
        experience: experienceController.text,
      );
    } else {
      CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('Error, Please enter all the fields.'),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTrainerCubit, CreateTrainerState>(
      listener: (context, state) {
        if (state is CreateTrainerFailure) {
          CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('CreateTrainerFailure'),);
        } else if (state is CreateTrainerSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('CreateTrainerSuccess'),);
          TrainersCubit.get(context).fetchTrainers(page: 1);
        } else if (state is ImagePickedSuccess) {
          CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('ImagePickedSuccess'),);
        }
      },
      builder: (context, state) {
        return BlocConsumer<UpdateTrainerCubit, UpdateTrainerState>(
          listener: (context, state) {
            if (state is UpdateTrainerFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateTrainerFailure'),);
            } else if (state is UpdateTrainerSuccess) {
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('UpdateTrainerSuccess'),);
              TrainersCubit.get(context).fetchTrainers(page: 1);
            } else if (state is ImagePickedSuccess) {
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('ImagePickedSuccess'),);
            }
          },
          builder: (context, state) {
            return BlocConsumer<DeleteTrainerCubit, DeleteTrainerState>(
              listener: (context, state) {
                if (state is DeleteTrainerFailure) {
                  CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteTrainerFailure'),);
                } else if (state is DeleteTrainerSuccess) {
                  CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteTrainerSuccess'),);
                  TrainersCubit.get(context).fetchTrainers(page: 1);
                }
              },
              builder: (context, state) {
                return BlocConsumer<TrainersCubit, TrainersState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if(state is TrainersSuccess){
                      return Padding(
                        padding: EdgeInsets.only(top: 56.0.h,),
                        child: CustomScreenBody(
                          title: AppLocalizations.of(context).translate('Trainers'),
                          showSearchField: true,
                          textSecondButton: AppLocalizations.of(context).translate('New trainer'),
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
                                              height: 918.h,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 160.w, vertical: 55.h),
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
                                                        AppLocalizations.of(context).translate('Add trainer'),
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
                                                                  validator: (value) {
                                                                    if (value?.isEmpty ?? true) {
                                                                      return AppLocalizations.of(context).translate('This field required');
                                                                    } else {
                                                                      if (!RegExp(r'\S+@\S+\.\S+')
                                                                          .hasMatch(value.toString())) {
                                                                        return "Please enter a valid email address";
                                                                      }
                                                                    }
                                                                    return null;
                                                                  }/*=> value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null*/,
                                                                ),
                                                                CustomLabelTextFormField(
                                                                  labelText: AppLocalizations.of(context).translate('Phone number'),
                                                                  showLabelText: true,
                                                                  controller: phoneController,
                                                                  topPadding: 42.h,
                                                                  bottomPadding: 0.h,
                                                                  leftPadding: 175.w,
                                                                  rightPadding: 127.w,
                                                                  validator: (value) {
                                                                    if (value?.isEmpty ?? true) {
                                                                      return AppLocalizations.of(context).translate('This field required');
                                                                    } else if (value!.length < 10) {
                                                                      return 'At least 10 characters';
                                                                    }
                                                                    return null;
                                                                  }/*=> value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null*/,
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
                                                                        validator: (value) {
                                                                          if (value?.isEmpty ?? true) {
                                                                            return AppLocalizations.of(context).translate('This field required');
                                                                          } else if (value!.length < 10) {
                                                                            return 'At least 10 characters';
                                                                          }
                                                                          return null;
                                                                        }/*=> value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null*/,
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
                                                              CustomLabelTextFormField(
                                                                labelText: AppLocalizations.of(context).translate('Password'),
                                                                showLabelText: true,
                                                                controller: passwordController,
                                                                topPadding: 42.h,
                                                                bottomPadding: 0.h,
                                                                leftPadding: 60.w,
                                                                rightPadding: 65.w,
                                                                validator: (value) {
                                                                  if (value?.isEmpty ?? true) {
                                                                    return AppLocalizations.of(context).translate('This field required');
                                                                  } else {
                                                                    if (value!.length < 8) {
                                                                      return 'password must be at least 8 characters';
                                                                    }
                                                                  }
                                                                  return null;
                                                                }/*=> value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null*/,
                                                              ),
                                                              CustomLabelTextFormField(
                                                                labelText: AppLocalizations.of(context).translate('Specification'),
                                                                showLabelText: true,
                                                                controller: specificationController,
                                                                topPadding: 42.h,
                                                                bottomPadding: 0.h,
                                                                leftPadding: 60.w,
                                                                rightPadding: 65.w,
                                                                validator: (value) => value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: CustomLabelTextFormField(
                                                            labelText: AppLocalizations.of(context).translate('Experience'),
                                                            showLabelText: true,
                                                            controller: experienceController,
                                                            boxHeight: 297.h,
                                                            maxLines: 9,
                                                            topPadding: 35.h,
                                                            bottomPadding: 0.h,
                                                            leftPadding: 0.w,
                                                            rightPadding: 128.w,
                                                            validator: (value) {
                                                              if (value?.isEmpty ?? true) {
                                                                return AppLocalizations.of(context).translate('This field required');
                                                              } else if (value!.length < 10) {
                                                                return 'At least 10 characters';
                                                              }
                                                              return null;
                                                            }/*=> value!.isEmpty ? AppLocalizations.of(context).translate('This field required') : null*/,
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
                                                            textButton: AppLocalizations.of(context).translate('Add trainer'),
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
                                                                specificationController
                                                                    .clear();
                                                                experienceController
                                                                    .clear();
                                                              }                                                            },
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
                                                              specificationController
                                                                  .clear();
                                                              experienceController
                                                                  .clear();
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
                            context.go(GoRouterPath.searchTrainer);
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
                                  state.showResult.trainers.data!.isNotEmpty ? CustomListInformationFields(
                                    secondField: AppLocalizations.of(context).translate('Subject'),
                                    showSecondField: true,
                                    widget: ListView.builder(
                                      itemBuilder: (BuildContext context, int index) {
                                        return Align(child: InformationFieldItem(
                                          color: index%2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                          image: state.showResult.trainers.data![index].photo,
                                          name: state.showResult.trainers.data![index].name,
                                          secondText: state.showResult.trainers.data![index].specialization,
                                          thirdDetailsText: state.showResult.trainers.data![index].email,
                                          fourthDetailsText: state.showResult.trainers.data![index].gender,
                                          showSecondDetailsText: true,
                                          showIcons: true,
                                          onTap: (){
                                            context.go('${GoRouterPath.trainerDetails}/${state.showResult.trainers.data![index].id}');
                                          },
                                          onTapFirstIcon: (){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext dialogContext) {
                                                return UpdateTrainerDialog(trainer: state.showResult.trainers.data![index], updateCubit: context.read<UpdateTrainerCubit>(),);
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
                                                                      AppLocalizations.of(context).translate('Warning'),
                                                                      style: Styles.h3Bold(color: AppColors.t3),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 75.h, left: 65.w, right: 155.w),
                                                                child: Text(
                                                                  AppLocalizations.of(context).translate('Are you sure you want to delete this trainer?'),
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
                                                                        context.read<DeleteTrainerCubit>().fetchDeleteTrainer(id: state.showResult.trainers.data![index].id);
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
                                            }
                                          },
                                        ));
                                      },
                                      itemCount: state.showResult.trainers.data!.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ) : CustomEmptyWidget(
                                    firstText: AppLocalizations.of(context).translate('No trainers at this time'),
                                    secondText: AppLocalizations.of(context).translate('Trainers will appear here after they enroll in your institute.'),
                                  ),
                                  CustomNumberPagination(
                                    numberPages: state.showResult.trainers.lastPage,
                                    initialPage: state.showResult.trainers.currentPage,
                                    onPageChange: (int index) {
                                      context.read<TrainersCubit>().fetchTrainers(page: index + 1);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if(state is TrainersFailure) {
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

class UpdateTrainerDialog extends StatefulWidget {
  const UpdateTrainerDialog({super.key, required this.trainer, required this.updateCubit});

  final DatumTrainer trainer;
  final UpdateTrainerCubit updateCubit;

  @override
  State<UpdateTrainerDialog> createState() => _UpdateTrainerDialogState();
}

class _UpdateTrainerDialogState extends State<UpdateTrainerDialog> {

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
    originalName = widget.trainer.name;
    originalPhone = widget.trainer.phone;
    originalBirthDate = widget.trainer.birthday;
    originalGender = widget.trainer.gender;
    originalImage = widget.trainer.photo;

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
        CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('No image selected or image data is unavailable.'),);
      }
    } catch (e) {
      CustomSnackBar.showErrorSnackBar(context, msg: '${AppLocalizations.of(context).translate('Failed to pick image:')} $e',);
    }
  }

  void update(int id) {
    widget.updateCubit.fetchUpdateTrainer(
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
                          AppLocalizations.of(context).translate('Edit trainer'),
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
                                    image: widget.trainer.photo,
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
                              textButton: AppLocalizations.of(context).translate('Edit trainer'),
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
                                update(widget.trainer.id);
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
          );
        }
    );
  }
}
