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
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../manager/search_trainer_cubit/search_trainer_cubit.dart';
import '../../manager/search_trainer_cubit/search_trainer_state.dart';

class SearchTrainerViewBody extends StatelessWidget {
  SearchTrainerViewBody({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTrainerCubit, SearchTrainerState>(
        builder: (context, state) {
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
                              showIcons: true,
                              hideFirstIcon: true,
                              hideSecondIcon: true,
                              onTap: () {
                                context.go('${GoRouterPath.trainerDetails}/${state.trainer.trainers.data![index].id}');
                              },
                              onTapFirstIcon: () {},
                              onTapSecondIcon: () {},
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
}
