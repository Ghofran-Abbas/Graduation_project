import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';

class CompleteViewBody extends StatelessWidget {
  const CompleteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Languages',
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
                GridViewCards(
                  text: 'Video Editing',
                  cardCount: 20,
                  showIcons: true,
                  detailsText: 'Section 1',
                  secondDetailsText: 'Media & Pro',
                  showDetailsText: true,
                  onTap: (){/*context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}');*/},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
