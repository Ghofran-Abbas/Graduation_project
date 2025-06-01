import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_over_loading_card.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../course/presentation/manager/files_cubit/files_cubit.dart';
import '../../../../course/presentation/manager/files_cubit/files_state.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_state.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';
import '../../../../report/presentation/manager/get_file_cubit/get_file_cubit.dart';
import '../../../../report/presentation/manager/get_file_cubit/get_file_state.dart';

class ArchiveSectionStudentViewBody extends StatelessWidget {
  const ArchiveSectionStudentViewBody({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    int count = 10;
    return Padding(
      padding: EdgeInsets.only(top: 56.0.h,),
      child: CustomScreenBody(
        title: 'Archive Video Editing',
        showSearchField: true,
        textFirstButton: 'Section 2',
        showFirstButton: true,
        onPressedFirst: (){},
        onPressedSecond: (){},
        body: Padding(
          padding: EdgeInsets.only(top: 238.0.h, left: 77.0.w, bottom: 27.0.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CustomCourseInformation(
                      showSectionInformation: true,
                      ratingText: '2.8',
                      ratingPercent: 1,
                      ratingPercentText: '100%',
                      circleStatusColor: AppColors.mintGreen,
                      courseStatusText: 'Complete',
                      startDateText: '2025-09-02',
                      showCourseCalenderIcon: true,
                      endDateText: '2025-12-02',
                      numberSeatsText: '40 Seats',
                      bodyText: 'Nulla Lorem mollit cupidatat irure. Laborum\n'
                          'magna nulla duis ullamco cillum dolor.\n'
                          'Voluptate exercitation incididunt aliquip\n'
                          'deserunt reprehenderit elit laborum. Nulla\n'
                          'Lorem mollit cupidatat irure. Laborum\n'
                          'magna nulla duis ullamco cillum dolor.\n'
                          'Voluptate exercitation incididunt aliquip\n'
                          'deserunt reprehenderit elit laborum. ',
                      onTap: (){},
                      onTapDate: (){
                        context.go('${GoRouterPath.studentDetails}/1${GoRouterPath.studentArchiveCourseView}/1${GoRouterPath.archiveSectionStudentView}/1${GoRouterPath.completeCalendar}/1');
                      },
                      onTapFirstIcon: (){},
                      onTapSecondIcon: (){},
                    ),
                    SizedBox(height: 22.h),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        BlocBuilder<StudentsSectionCubit, StudentsSectionState>(
                            builder: (contextSS, stateSS) {
                              if(stateSS is StudentsSectionSuccess) {
                                return Row(
                                  children: [
                                    CustomOverloadingAvatar(
                                      labelText: '${AppLocalizations.of(context).translate('Look at')} ${stateSS.students.students.data![0].students!.length} ${AppLocalizations.of(context).translate('students in this class')}',
                                      tailText: AppLocalizations.of(context).translate('See more'),
                                      firstImage: stateSS.students.students.data![0].students!.isNotEmpty ? stateSS.students.students.data![0].students![0].photo : '',
                                      secondImage: stateSS.students.students.data![0].students!.length >= 2 ? stateSS.students.students.data![0].students![1].photo : '',
                                      thirdImage: stateSS.students.students.data![0].students!.length >= 3 ? stateSS.students.students.data![0].students![2].photo : '',
                                      fourthImage: stateSS.students.students.data![0].students!.length >= 4 ? stateSS.students.students.data![0].students![3].photo : '',
                                      fifthImage: stateSS.students.students.data![0].students!.length >= 5 ? stateSS.students.students.data![0].students![4].photo : '',
                                      avatarCount: stateSS.students.students.data![0].students!.length,
                                      onTap: () {
                                        if(stateSS.students.students.data![0].students!.isNotEmpty) {
                                          context.go('${GoRouterPath.studentDetails}/${stateSS.students.students.data![0].students![0].id}${GoRouterPath.studentArchiveCourseView}/${stateSS.students.students.data![0].students![0].id}${GoRouterPath.archiveSectionStudentView}/${stateSS.students.students.data![0].id}${GoRouterPath.completeStudents}/${stateSS.students.students.data![0].id}');
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: calculateWidthBetweenAvatars(avatarCount: stateSS.students.students.data![0].students!.length) /*270.w*/,),
                                  ],
                                );
                              } else if(stateSS is StudentsSectionFailure) {
                                return Row(
                                  children: [
                                    CustomOverloadingAvatar(
                                      labelText: '${AppLocalizations.of(context).translate('Look at')} ${AppLocalizations.of(context).translate('students in this class')}',
                                      tailText: AppLocalizations.of(context).translate('See more'),
                                      firstImage: '',
                                      secondImage: '',
                                      thirdImage: '',
                                      fourthImage: '',
                                      fifthImage: '',
                                      avatarCount: 5,
                                      onTap: () {},
                                    ),
                                    SizedBox(
                                      width: calculateWidthBetweenAvatars(avatarCount: 5) /*270.w*/,),
                                  ],
                                );
                              } else {
                                return CustomCircularProgressIndicator();
                              }
                            }
                        ),
                        BlocBuilder<TrainersSectionCubit, TrainersSectionState>(
                            builder: (contextTS, stateTS) {
                              if(stateTS is TrainersSectionSuccess) {
                                return Expanded(
                                  child: CustomOverloadingAvatar(
                                    labelText: '${AppLocalizations.of(context).translate('Look at')} ${stateTS.trainers.trainers![0].trainers!.length} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                    tailText: AppLocalizations.of(context).translate('See more'),
                                    firstImage: stateTS.trainers.trainers![0].trainers!.isNotEmpty ? stateTS.trainers.trainers![0].trainers![0].photo : '',
                                    secondImage: stateTS.trainers.trainers![0].trainers!.length >= 2 ? stateTS.trainers.trainers![0].trainers![1].photo : '',
                                    thirdImage: stateTS.trainers.trainers![0].trainers!.length >= 3 ? stateTS.trainers.trainers![0].trainers![2].photo : '',
                                    fourthImage: stateTS.trainers.trainers![0].trainers!.length >= 4 ? stateTS.trainers.trainers![0].trainers![3].photo : '',
                                    fifthImage: stateTS.trainers.trainers![0].trainers!.length >= 5 ? stateTS.trainers.trainers![0].trainers![4].photo : '',
                                    avatarCount: stateTS.trainers.trainers![0].trainers!.length,
                                    onTap: () {
                                      if(stateTS.trainers.trainers![0].trainers!.isNotEmpty) {
                                        context.go('${GoRouterPath.studentDetails}/${stateTS.trainers.trainers![0].trainers![0].id}${GoRouterPath.studentArchiveCourseView}/${stateTS.trainers.trainers![0].trainers![0].id}${GoRouterPath.archiveSectionStudentView}/${stateTS.trainers.trainers![0].id}${GoRouterPath.completeTrainers}/${stateTS.trainers.trainers![0].id}');
                                      } /*else {
                                        context.go('${GoRouterPath.studentDetails}/1${GoRouterPath.studentArchiveCourseView}/1${GoRouterPath.archiveSectionCourseView}/1${GoRouterPath.completeStudents}/1');
                                      }*/
                                    },
                                  ),
                                );
                              } else if(stateTS is TrainersSectionFailure) {
                                return Row(
                                  children: [
                                    CustomOverloadingAvatar(
                                      labelText: '${AppLocalizations.of(context).translate('Look at')} ${AppLocalizations.of(context).translate('trainers in this class')}',
                                      tailText: AppLocalizations.of(context).translate('See more'),
                                      firstImage: '',
                                      secondImage: '',
                                      thirdImage: '',
                                      fourthImage: '',
                                      fifthImage: '',
                                      avatarCount: 5,
                                      onTap: () {},
                                    ),
                                    SizedBox(
                                      width: calculateWidthBetweenAvatars(avatarCount: 5) /*270.w*/,),
                                  ],
                                );
                              } else {
                                return CustomCircularProgressIndicator();
                              }
                            }
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h, right: 47.0.w,),
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 70.h,
                              child: TabBar(
                                labelColor: AppColors.blue,
                                unselectedLabelColor: AppColors.blue,
                                indicator: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.darkBlue,
                                ),
                                indicatorPadding: EdgeInsets.only(top: 48.r, bottom: 12.r),
                                indicatorWeight: 20,
                                labelStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                                tabs: [
                                  Tab(text: AppLocalizations.of(context).translate('         File         '),),
                                  Tab(text: AppLocalizations.of(context).translate('Announcement')),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 570.23.h,
                              child: TabBarView(
                                children: [
                                  BlocBuilder<FilesCubit, FilesState>(
                                      builder: (contextF, stateF) {
                                        return BlocConsumer<GetFileCubit, GetFileState>(
                                            listener: (context, state) {
                                              if (state is GetFileLoading) {
                                                CustomSnackBar.showErrorSnackBar(context, msg: AppLocalizations.of(context).translate('GetFileLoading'),color: AppColors.darkLightPurple, textColor: AppColors.black);
                                              } else if (state is GetFileSuccess) {
                                                CustomSnackBar.showSnackBar(context, msg: AppLocalizations.of(context).translate('GetFileSuccess'),);
                                              }
                                            },
                                            builder: (contextGF, stateGF) {
                                              if(stateF is FilesSuccess) {
                                                return Column(
                                                  children: [
                                                    GridView.builder(
                                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10.w, mainAxisExtent: 100.h),
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return Align(
                                                          child: FileItem(
                                                            fileName: stateF.files.files.data![index].fileName,
                                                            color: index%2 != 0 ? AppColors.white : AppColors.darkHighlightPurple,
                                                            onTap: () {
                                                              GetFileCubit.get(context).fetchFile(filePath: stateF.files.files.data![index].filePath);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      itemCount: stateF.files.files.data!.length,
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                    ),
                                                    CustomNumberPagination(
                                                      numberPages: stateF.files.files.lastPage,
                                                      initialPage: stateF.files.files.currentPage,
                                                      onPageChange: (int index) {
                                                        FilesCubit.get(context).fetchFiles(sectionId: sectionId, page: index+1);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              } else if(stateF is FilesFailure) {
                                                return CustomErrorWidget(
                                                    errorMessage: stateF.errorMessage);
                                              } else {
                                                return CustomCircularProgressIndicator();
                                              }
                                            }
                                        );
                                      }
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
