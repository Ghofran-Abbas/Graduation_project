import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';

class AnnouncementCDetailsViewBody extends StatelessWidget {
  const AnnouncementCDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: CustomScreenBody(
          title: 'Announcement'/*state.report.report.name*/,
          onPressedFirst: () {},
          onPressedSecond: () {},
          body: Padding(
            padding: EdgeInsets.only(top: 195.0.h,
                left: 20.0.w,
                right: 20.0.w,
                bottom: 27.0.h),
            child: CustomDetailsInformation(
              //image: ''/*state.report.report.secretary.photo*/,
              startDate: '2025-04-19',
              endDate: '2025-08-15',
              detailsText: 'Discount 30%',
              aboutText: 'ewsrhdtjuijoklljhgfdfxcghujkl'/*state.report.report.description*/,
              showFileTapText: true,
              showDetailsText: true,
              isAnnouncement: true,
              showAboutText: true,
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
