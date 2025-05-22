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
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/custom_top_information_field.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';
import '../../../../course/presentation/manager/delete_section_trainer_cubit/delete_section_trainer_cubit.dart';
import '../../../../course/presentation/manager/delete_section_trainer_cubit/delete_section_trainer_state.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';

class InPreparationTrainersViewBody extends StatelessWidget {
  const InPreparationTrainersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteSectionTrainerCubit, DeleteSectionTrainerState>(
        listener: (context, state) {
          if (state is DeleteSectionTrainerFailure) {
            CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteSectionTrainerFailure'),);
          } else if (state is DeleteSectionTrainerSuccess) {
            CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('DeleteSectionTrainerSuccess'),);
          }
        },
        builder: (context, state) {
          return BlocBuilder<TrainersSectionCubit, TrainersSectionState>(
              builder: (context, state) {
                if(state is TrainersSectionSuccess) {
                  return Padding(
                    padding: EdgeInsets.only(top: 56.0.h,),
                    child: CustomScreenBody(
                      title: state.trainers.trainers![0].name,
                      textSecondButton: AppLocalizations.of(context).translate('Add trainer'),
                      showSecondButton: true,
                      onPressedFirst: () {},
                      onPressedSecond: () {
                        context.go('${GoRouterPath.inPreparationDetails}/${state.trainers.trainers![0].id}${GoRouterPath.inPreparationTrainers}/${state.trainers.trainers![0].id}${GoRouterPath.searchTrainerIp}/${state.trainers.trainers![0].id}');
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
                                firstText: '${state.trainers.trainers![0].trainers!.length} ${AppLocalizations.of(context).translate('Trainer')}',
                                firstIconColor: AppColors.purple,
                                secondText: '${DateFormat('yyyy-MM-dd').format(DateTime.now())}    ${DateFormat.EEEE().format(DateTime.now())}',
                                secondIcon: Icons.calendar_today_outlined,
                                secondIconColor: AppColors.purple,
                                thirdText: '10:00 Am - 11:00 Am',
                                thirdIcon: Icons.watch_later_outlined,
                                thirdIconColor: AppColors.purple,
                                isTrainer: true,
                              ),
                              SizedBox(height: 40.h,),
                              CustomListInformationFields(
                                secondField: AppLocalizations.of(context).translate('Subject'),
                                showSecondField: true,
                                showSecondBox: true,
                                widget: state.trainers.trainers![0].trainers!.isNotEmpty ? ListView.builder(
                                  itemBuilder: (BuildContext context, int index) {
                                    return Align(child: InformationFieldItem(
                                      color: index % 2 != 0 ? AppColors
                                          .darkHighlightPurple : AppColors.white,
                                      image: state.trainers.trainers![0].trainers![index].photo,
                                      name: state.trainers.trainers![0].trainers![index].name,
                                      secondText: state.trainers.trainers![0].trainers![index].specialization,
                                      showSecondDetailsText: true,
                                      thirdDetailsText: state.trainers.trainers![0].trainers![index].email,
                                      fourthDetailsText: state.trainers.trainers![0].trainers![index].gender,
                                      showFirstBox: true,
                                      showSecondBox: true,
                                      showIcons: true,
                                      hideFirstIcon: true,
                                      onTap: () {
                                        context.go('${GoRouterPath.trainerDetails}/${state.trainers.trainers![0].trainers![index].id}');
                                      },
                                      onTapFirstIcon: () {},
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
                                                            AppLocalizations.of(context).translate(AppLocalizations.of(context).translate('Are you sure you want to remove this trainer from section?')),
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
                                                                  context.read<DeleteSectionTrainerCubit>().fetchDeleteSectionTrainer(sectionId: state.trainers.trainers![0].id, trainerId: state.trainers.trainers![0].trainers![index].id,);
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
                                  itemCount: state.trainers.trainers![0].trainers!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                )  : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('No thing to display'))),
                              ),
                              CustomNumberPagination(
                                numberPages: 1/*state.trainers.trainers![0].lastPage*/,
                                initialPage: 1/*state.showResult.departments.currentPage*/,
                                onPageChange: (int index) {
                                  context.read<TrainersSectionCubit>().fetchTrainersSection(id: state.trainers.trainers![0].id, page: index + 1);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if(state is TrainersSectionFailure) {
                  return CustomErrorWidget(
                      errorMessage: state.errorMessage);
                } else {
                  return CustomCircularProgressIndicator();
                }
              }
          );
        }
    );
  }
}
