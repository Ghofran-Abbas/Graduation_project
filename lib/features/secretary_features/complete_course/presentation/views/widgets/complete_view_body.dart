import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';

class CompleteViewBody extends StatelessWidget {
  const CompleteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: AppLocalizations.of(context).translate('Complete'),
        showSearchField: true,
        onPressedFirst: (){},
        onPressedSecond: (){},
        body: Padding(
          padding: EdgeInsets.only(top: 238.0.h, left: 47.0.w, right: 47.0.w, bottom: 27.0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, crossAxisSpacing: 10.w, mainAxisExtent: 354.66.h),
                  itemBuilder: (BuildContext context, int index) {
                    return Align(child: CustomCard(
                      text: 'Video Editing',
                      detailsText: 'Section 1',
                      secondDetailsText: 'Media & Pro',
                      showDetailsText: true,
                      showRating: true,
                      showCheckEndCourse: true,
                      ratingText: '2.8',
                      ratingIcon: Icons.star,
                      onTap: (){context.go('${GoRouterPath.completeDetails}/1');},
                      onTapFirstIcon: (){},
                      onTapSecondIcon: (){},
                    ));
                  },
                  itemCount: 20,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
