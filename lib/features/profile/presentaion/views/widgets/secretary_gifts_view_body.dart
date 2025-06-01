import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/utils/go_router_path.dart';
import '../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../manager/gifts_cubit/gifts_cubit.dart';
import '../../manager/gifts_cubit/gifts_state.dart';

class SecretaryGiftsViewBody extends StatelessWidget {
  const SecretaryGiftsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    return BlocBuilder<GiftsCubit, GiftsState>(
      builder: (context, state) {
        if(state is GiftsSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 56.0.h,),
            child: CustomScreenBody(
              title: AppLocalizations.of(context).translate('Gifts'),
              showSearchField: true,
              onPressedFirst: () {},
              onPressedSecond: () {},
              body: Padding(
                padding: EdgeInsets.only(
                    top: 238.0.h, left: 47.0.w, right: 47.0.w, bottom: 27.0.h),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.gifts.gifts!.isNotEmpty ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10.w,
                            mainAxisExtent: 354.66.h),
                        itemBuilder: (BuildContext context, int index) {
                          return Align(child: CustomCard(
                            image: state.gifts.gifts![index].photo,
                            text: state.gifts.gifts![index].description,
                            dateText: state.gifts.gifts![index].date.toString().replaceRange(10, 24, ''),
                            showDate: true,
                            onTap: () {
                              context.go(
                                  '${GoRouterPath.secretaryGiftDetails}/${state.gifts.gifts![index].id}');
                            },
                            onTapFirstIcon: () {},
                            onTapSecondIcon: () {},
                          ));
                        },
                        itemCount: state.gifts.gifts!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ) : CustomEmptyWidget(
                        firstText: AppLocalizations.of(context).translate('No gifts at this time'),
                        secondText: AppLocalizations.of(context).translate('Gifts will appear here after they enroll in your institute.'),
                      ),
                      CustomNumberPagination(
                        numberPages: state.gifts.pagination.lastPage,
                        initialPage: state.gifts.pagination.currentPage,
                        onPageChange: (int index) {
                          context.read<GiftsCubit>().fetchGifts(page: index + 1);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if(state is GiftsFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
