import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/custom_top_information_field.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';

class CompleteStudentsViewBody extends StatelessWidget {
  const CompleteStudentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Students',
        onPressedFirst: () {},
        onPressedSecond: () {},
        body:Padding(
          padding: EdgeInsets.only(top: 238.0.h,
              left: 20.0.w,
              right: 20.0.w,
              bottom: 27.0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomTopInformationField(
                  firstText: '8 Seats',
                  secondText: '4 Seats',
                  thirdText: '7 Seats',
                ),
                SizedBox(height: 40.h,),
                CustomListInformationFields(
                  secondField: AppLocalizations.of(context).translate('Birth date'),
                  showSecondField: true,
                  showFifthField: true,
                  widget: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Align(child: InformationFieldItem(
                        color: index % 2 != 0 ? AppColors.darkHighlightPurple : AppColors.white,
                        //image: state.showResult.students.data![index].photo,
                        name: 'Harmony Granger'/*state.showResult.students.data![index].name*/,
                        secondText: '2001-10-08'/*state.showResult.students.data![index].birthday*/,
                        showSecondDetailsText: true,
                        thirdDetailsText: 'hogwarts@gmail.com'/*state.showResult.students.data![index].email*/,
                        fourthDetailsText: 'Female',
                        fifthText: 'Complete',
                        showFifthDetailsText: true,
                        onTap: () {
                          //context.go('${GoRouterPath.studentDetails}/${state.showResult.students.data![index].id}');
                        },
                        onTapFirstIcon: (){},
                        onTapSecondIcon: (){},
                      ));
                    },
                    itemCount: 10/*state.showResult.students.data!.length*/,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
