import 'package:alhadara_dashboard/features/secretary_features/department/presentation/manager/departments_cubit/departments_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/department/presentation/manager/departments_cubit/departments_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/assets.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';

class DepartmentsViewBody extends StatelessWidget {
  const DepartmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    return BlocConsumer<DepartmentsCubit, DepartmentsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is DepartmentsSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 56.0.h,),
            child: CustomScreenBody(
              title: AppLocalizations.of(context).translate('Departments'),
              onPressedFirst: () {},
              onPressedSecond: () {},
              body: Padding(
                padding: EdgeInsets.only(
                    top: 238.0.h, left: 47.0.w, right: 47.0.w, bottom: 27.0.h),
                //padding: EdgeInsets.only(top: 171.0, left: 50.0, right: 50.0, bottom: 20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.showResult.departments.data!.isNotEmpty ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10.w,
                            mainAxisExtent: 354.66.h),
                        itemBuilder: (BuildContext context, int index) {
                          return Align(child: CustomCard(
                            image: state.showResult.departments.data![index].photo,
                            text: state.showResult.departments.data![index].name,
                            onTap: () {
                              context.go('${GoRouterPath.courses}/${state.showResult.departments.data![index].id}');
                            },
                            onTapFirstIcon: (){},
                            onTapSecondIcon: (){},
                          ));
                        },
                        itemCount: state.showResult.departments.data!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ) : CustomEmptyWidget(
                        firstText: AppLocalizations.of(context).translate('No departments at this time'),
                        secondText: AppLocalizations.of(context).translate('Departments will appear here after they enroll in your institute.'),
                      ),
                      CustomNumberPagination(
                        numberPages: state.showResult.departments.lastPage,
                        initialPage: state.showResult.departments.currentPage,
                        onPageChange: (int index) {
                          context.read<DepartmentsCubit>().fetchDepartments(page: index + 1);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if(state is DepartmentsFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
