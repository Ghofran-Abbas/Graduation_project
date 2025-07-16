import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/go_router_path.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/custom_number_pagination.dart';
import '../../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../../../core/widgets/secretary/custom_course_information.dart';
import '../../../../../../core/widgets/secretary/custom_empty_widget.dart';
import '../../../../../../core/widgets/secretary/custom_over_loading_card.dart';
import '../../../../../../core/widgets/secretary/custom_overloading_avatar.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';
import '../../../../../../core/widgets/secretary/grid_view_cards.dart';
import '../../../../../../core/widgets/secretary/grid_view_files.dart';
import '../../../../course/presentation/manager/details_course_cubit/details_course_cubit.dart';
import '../../../../course/presentation/manager/details_course_cubit/details_course_state.dart';
import '../../../../course/presentation/manager/files_cubit/files_cubit.dart';
import '../../../../course/presentation/manager/files_cubit/files_state.dart';
import '../../../../course/presentation/manager/section_progress_cubit/section_progress_cubit.dart';
import '../../../../course/presentation/manager/section_progress_cubit/section_progress_state.dart';
import '../../../../course/presentation/manager/section_rating_cubit/section_rating_cubit.dart';
import '../../../../course/presentation/manager/section_rating_cubit/section_rating_state.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_cubit.dart';
import '../../../../course/presentation/manager/students_section_cubit/students_section_state.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_cubit.dart';
import '../../../../course/presentation/manager/trainers_section_cubit/trainers_section_state.dart';
import '../../../../course/presentation/views/widgets/course_details_view_body.dart';
import '../../../../report/presentation/manager/get_file_cubit/get_file_cubit.dart';
import '../../../../report/presentation/manager/get_file_cubit/get_file_state.dart';
import '../../../data/models/complete_model.dart';
import '../../manager/complete_cubit/complete_cubit.dart';
import '../../manager/complete_cubit/complete_state.dart';

class CompleteDetailsViewBody extends StatelessWidget {
  const CompleteDetailsViewBody({super.key, required this.courseId});

  final int courseId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 250).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;
    int count = 10;
    return BlocConsumer<DetailsCourseCubit, DetailsCourseState>(
      listener: (contextDC, stateDC) {},
      builder: (contextDC, stateDC)  {
        if(stateDC is DetailsCourseSuccess) {
          return BlocConsumer<CompleteCubit, CompleteState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CompleteSuccess) {
                final List<DatumComplete> sections = state.createResult.data!;
                return Padding(
                  padding: EdgeInsets.only(top: 56.0.h,),
                  child: CustomScreenBody(
                    title: stateDC.course.course.name,
                    textFirstButton: 'Section 2',
                    showFirstButton: true,
                    widget: BlocBuilder<SelectCompleteCubit, SelectCompleteState>(
                      builder: (context, selectState) {
                        DatumComplete? selected;
                        if (selectState is SelectCompleteSuccess) {
                          selected = selectState.section;
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 0.h, bottom: 0.h),
                          child: DropdownMenu<DatumComplete>(
                            enableSearch: false,
                            requestFocusOnTap: false,
                            width: 200.w,
                            hintText: AppLocalizations.of(context).translate('No section'),
                            initialSelection: selected,
                            inputDecorationTheme: InputDecorationTheme(
                              constraints: BoxConstraints(
                                  maxHeight: 53.h),
                              hintStyle: Styles.l1Normal(
                                  color: AppColors.t0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.purple,
                                  width: 1.23,
                                ),
                                borderRadius: BorderRadius.circular(
                                    24.67.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.purple,
                                  width: 1.23,
                                ),
                                borderRadius: BorderRadius.circular(
                                    24.67.r),
                              ),
                            ),
                            alignmentOffset: Offset(4, 2),
                            menuStyle: MenuStyle(
                              backgroundColor: WidgetStateColor
                                  .resolveWith(
                                    (states) {
                                  return AppColors.white;
                                },
                              ),
                              elevation: WidgetStateProperty.resolveWith(
                                    (states) {
                                  return 0;
                                },
                              ),
                              side: WidgetStateBorderSide.resolveWith(
                                    (states) {
                                  return BorderSide(
                                    width: 1.23,
                                    color: AppColors.purple,

                                  );
                                },
                              ),

                            ),
                            dropdownMenuEntries: sections.map((section) {
                              return DropdownMenuEntry<DatumComplete>(
                                value: section,
                                label: section.name,
                              );
                            }).toList(),
                            onSelected: (DatumComplete? selectedSection) {
                              if (selectedSection != null) {
                                BlocProvider.of<SelectCompleteCubit>(
                                    context).selectSection(
                                    section: selectedSection);
                                log('✅ Selected ID: ${selectedSection
                                    .id}');
                              }
                            },
                          ),
                        );
                      },
                    ),
                    onPressedFirst: (){},
                    onPressedSecond: (){},
                    body: BlocConsumer<SelectCompleteCubit, SelectCompleteState>(
                        listener: (contextSec, stateSec) {
                          if (stateSec is SelectCompleteSuccess) {
                            SectionRatingCubit.get(context).fetchSectionRating(sectionId: stateSec.section.id);
                            SectionProgressCubit.get(context).fetchSectionProgress(sectionId: stateSec.section.id);
                            TrainersSectionCubit.get(context).fetchTrainersSection(id: stateSec.section.id, page: 1);
                            StudentsSectionCubit.get(context).fetchStudentsSection(id: stateSec.section.id, page: 1);
                            FilesCubit.get(context).fetchFiles(sectionId: stateSec.section.id, page: 1);
                          }
                        },
                        builder: (context, stateSec) {
                          if (stateSec is SelectCompleteSuccess) {
                            return Padding(
                              padding: EdgeInsets.only(top: 238.0.h, left: 77.0.w, bottom: 27.0.h),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        BlocBuilder<SectionRatingCubit, SectionRatingState>(
                                            builder: (contextR, stateR) {
                                              return BlocBuilder<SectionProgressCubit, SectionProgressState>(
                                                builder: (contextP, stateP) {
                                                  if(stateP is SectionProgressSuccess) {
                                                    return CustomCourseInformation(
                                                      image: stateDC.course.course.photo,
                                                      showSectionInformation: true,
                                                      ratingText: stateR is SectionRatingSuccess ? (stateR.sectionRating.averageRating == null ? '0.0' : stateR.sectionRating.averageRating!.replaceRange(2, 5, '')) : stateR is SectionRatingLoading ? '...' : '!',
                                                      ratingPercent: double.parse('${stateP.sectionProgress.progressPercentage}') / 100,
                                                      ratingPercentText: '${stateP.sectionProgress.progressPercentage}%',
                                                      circleStatusColor: AppColors.mintGreen,
                                                      courseStatusText: handleReceiveState(state: stateSec.section.state),
                                                      startDateText: stateSec.section.startDate.toString().replaceRange(10, 23, ''),
                                                      showCourseCalenderIcon: true,
                                                      endDateText: stateSec.section.endDate.toString().replaceRange(10, 23, ''),
                                                      numberSeatsText: '${stateSec.section.seatsOfNumber} ${AppLocalizations.of(context).translate('Seats')}',
                                                      bodyText: stateDC.course.course.description,
                                                      onTap: (){},
                                                      onTapDate: (){
                                                        context.go('${GoRouterPath.completeDetails}/$courseId${GoRouterPath.completeCalendar}/${stateSec.section.id}');
                                                      },
                                                      onTapRating: () {
                                                        context.go('${GoRouterPath.completeDetails}/$courseId${GoRouterPath.completeRating}/$courseId');
                                                      },
                                                      onTapFirstIcon: (){},
                                                      onTapSecondIcon: (){},
                                                    );
                                                  }else if(stateP is SectionProgressFailure) {
                                                    return CustomErrorWidget(
                                                        errorMessage: stateP.errorMessage);
                                                  } else {
                                                    return CustomCircularProgressIndicator();
                                                  }
                                                }
                                              );
                                            }
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
                                                          onTap: () {context.go('${GoRouterPath.completeDetails}/${stateSS.students.students.data![0].id}${GoRouterPath.completeStudents}/${stateSS.students.students.data![0].id}');
                                                            //onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
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
                                                          onTap: () {//context.go('${GoRouterPath.completeDetails}/1${GoRouterPath.completeStudents}/1');
                                                            //onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                          },
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
                                                          context.go('${GoRouterPath.completeDetails}/${stateTS.trainers.trainers![0].id}${GoRouterPath.completeTrainers}/${stateTS.trainers.trainers![0].id}');
                                                          //context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionTrainers}/${state.section.id}');
                                                        },
                                                      ),
                                                    );
                                                  } else if(stateTS is TrainersSectionFailure) {
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
                                                          onTap: () {context.go('${GoRouterPath.completeDetails}/1${GoRouterPath.completeTrainers}/1');
                                                            //onTap: () {context.go('${GoRouterPath.courses}/${stateDC.course.course.departmentId}${GoRouterPath.courseDetails}/${stateDC.course.course.id}${GoRouterPath.sectionStudents}/${stateSec.section.id}');
                                                          },
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
                                                                            FilesCubit.get(context).fetchFiles(sectionId: courseId, page: index+1);
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
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: 238.0.h,
                                  left: 77.0.w,
                                  bottom: 27.0.h),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    Column(
                                      children: [
                                        CustomCourseInformation(
                                          image: stateDC.course.course.photo,
                                          bodyText: stateDC.course.course.description,
                                          onTap: () {},
                                          onTapDate: () {},
                                          onTapFirstIcon: (){},
                                          onTapSecondIcon: (){},
                                        ),
                                        //SizedBox(height: 22.h),
                                        Padding(
                                          padding: EdgeInsets.only(right: 87.w),
                                          child: CustomEmptyWidget(
                                            firstText: AppLocalizations.of(context).translate('No more at this time'),
                                            secondText: AppLocalizations.of(context).translate('Add a section to see more options.'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                    ),
                  ),
                );
              } else if (state is CompleteFailure) {
                return CustomErrorWidget(
                    errorMessage: state.errorMessage);
              } else {
                return CustomCircularProgressIndicator();
              }
            }
          );
        } else if(stateDC is DetailsCourseFailure) {
          return CustomErrorWidget(
              errorMessage: stateDC.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
