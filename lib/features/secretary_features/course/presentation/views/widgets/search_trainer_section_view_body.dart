import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/add_section_trainer_cubit/add_section_trainer_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/course/presentation/manager/add_section_trainer_cubit/add_section_trainer_state.dart';
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
import '../../../../trainer/presentation/manager/search_trainer_cubit/search_trainer_cubit.dart';
import '../../../../trainer/presentation/manager/search_trainer_cubit/search_trainer_state.dart';

class SearchTrainerSectionViewBody extends StatelessWidget {
  SearchTrainerSectionViewBody({super.key, required this.sectionId});

  final int sectionId;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTrainerCubit, SearchTrainerState>(
      builder: (context, state) {
        return BlocConsumer<AddSectionTrainerCubit, AddSectionTrainerState>(
          listener: (contextA, stateA) {
            if (stateA is AddSectionTrainerFailure) {
              CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('AddSectionTrainerFailure'),);
            } else if (stateA is AddSectionTrainerSuccess) {
              CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('AddSectionTrainerSuccess'),);
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
                  context.read<SearchTrainerCubit>().fetchSearchTrainer(querySearch: searchController.text, page: 1);
                },
                body: Padding(
                  padding: EdgeInsets.only(top: 238.0.h,
                      left: 20.0.w,
                      right: 20.0.w,
                      bottom: 27.0.h),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: state is SearchTrainerSuccess ? Column(
                      children: [
                        CustomListInformationFields(
                          secondField: AppLocalizations.of(context).translate('Subject'),
                          showSecondField: true,
                          widget: state.trainer.trainers.data!.isNotEmpty ?ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Align(child: InformationFieldItem(
                                color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                                image: state.trainer.trainers.data![index].photo,
                                name: state.trainer.trainers.data![index].name,
                                secondText: state.trainer.trainers.data![index].specialization,
                                showSecondDetailsText: true,
                                thirdDetailsText: state.trainer.trainers.data![index].email,
                                fourthDetailsText: state.trainer.trainers.data![index].gender,
                                showFirstBox: true,
                                showIcons: true,
                                hideFirstIcon: true,
                                hideSecondIcon: true,
                                onTap: () {
                                  context.go('${GoRouterPath.trainerDetails}/${state.trainer.trainers.data![index].id}');
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
                                                      AppLocalizations.of(context).translate('Are you sure you want to add this trainer to section?'),
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
                                                            contextA.read<AddSectionTrainerCubit>().fetchAddSectionTrainer(sectionId: sectionId, trainerId: state.trainer.trainers.data![index].id);
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
                            itemCount: state.trainer.trainers.data!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ) : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('No thing to display'))),
                        ),
                        CustomNumberPagination(
                          numberPages: state.trainer.trainers.lastPage,
                          initialPage: state.trainer.trainers.currentPage,
                          onPageChange: (int index) {
                            context.read<SearchTrainerCubit>().fetchSearchTrainer(querySearch: searchController.text, page: index + 1);
                          },
                        ),
                      ],
                    ) : state is SearchTrainerFailure ? CustomErrorWidget(errorMessage: state.errorMessage)
                        : state is SearchTrainerLoading ? CustomCircularProgressIndicator()
                          : Center(heightFactor: 20.h,child: CustomErrorWidget(errorMessage: AppLocalizations.of(context).translate('Search to see more'))),
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}
