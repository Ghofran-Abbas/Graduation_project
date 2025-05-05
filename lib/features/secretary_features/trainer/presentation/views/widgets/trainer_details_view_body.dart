import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/secretary/custom_profile_cards.dart';
import '../../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';

class TrainerDetailsViewBody extends StatelessWidget {
  const TrainerDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Trainers',
        showSearchField: true,
        onPressedFirst: (){},
        onPressedSecond: (){},
        body: Padding(
          padding: EdgeInsets.only(top: 238.0.h, left: 20.0.w, right: 20.0.w, bottom: 27.0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomProfileInformation(
                  name: 'Kristin Watson',
                  detailsText: 'French trainer',
                  showDetailsText: true,
                  firstBoxText: '+42 249 22 873',
                  firstBoxIcon: Icons.phone_in_talk_outlined,
                  secondBoxText: 'mickelle.rivera@exmple.com',
                  secondBoxIcon: Icons.mail_outlined,
                  aboutText: 'Nulla Lorem mollit cupidatat irure. Laborum\n'
                      'magna nulla duis ullamco cillum dolor.\n'
                      'Voluptate exercitation incididunt aliquip\n'
                      'deserunt reprehenderit elit laborum. Nulla\n'
                      'Lorem mollit cupidatat irure. Laborum\n'
                      'magna nulla duis ullamco cillum dolor.\n'
                      'Voluptate exercitation incididunt aliquip\n'
                      'deserunt reprehenderit elit laborum. ',
                  showAboutText: true,
                  firstFieldInfoText: '2002-07-05',
                  secondFieldInfoText: 'Female',
                  labelText: 'Students from the same class',
                  tailText: 'See more',
                  avatarCount: 1,
                  onTap: (){},
                ),
                CustomProfileCards(
                  labelText: 'Courses by Kristin',
                  text: 'English',
                  showDetailsText: true,
                  detailsText: 'Section1',
                  secondDetailsText: 'Languages',
                  showSecondDetailsText: true,
                  cardCount: 5,
                  onTapCard: (){},
                  onTapSeeMore: (){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
