import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/secretary/custom_list_information_fields.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/custom_top_information_field.dart';
import '../../../../../../core/widgets/secretary/list_view_information_field.dart';
import '../../../../../../core/widgets/text_icon_button.dart';

class SectionStudentsViewBody extends StatelessWidget {
  const SectionStudentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Students',
        textSecondButton: AppLocalizations.of(context).translate('Add student'),
        showSecondButton: true,
        onPressedFirst: () {},
        onPressedSecond: () {
          context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/1${GoRouterPath.sectionStudents}/1${GoRouterPath.searchStudentSection}/3');
          //context.go('${GoRouterPath.courses}/1${GoRouterPath.courseDetails}/${state.trainers.trainers![0].courseId}${GoRouterPath.sectionTrainers}/${state.trainers.trainers![0].id}${GoRouterPath.searchTrainerSection}/${state.trainers.trainers![0].id}');
        },
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
                  showFirstBox: true,
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
                        showFirstBox: true,
                        showIcons: true,
                        hideFirstIcon: true,
                        onTap: () {
                          //context.go('${GoRouterPath.studentDetails}/${state.showResult.students.data![index].id}');
                        },
                        onTapFirstIcon: (){},
                        onTapSecondIcon: (){
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
                                              AppLocalizations.of(context).translate('Are you sure you want to remove this student from section?'),
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
                                                    //context.read<DeleteStudentCubit>().fetchDeleteStudent(id: state.showResult.students.data![index].id);
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
