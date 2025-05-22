import 'package:alhadara_dashboard/features/secretary_features/report/presentation/manager/details_report_cubit/details_report_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/presentation/manager/details_report_cubit/details_report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_circular_progress_indicator.dart';
import '../../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../../core/widgets/secretary/custom_profile_information.dart';
import '../../../../../../core/widgets/secretary/custom_screen_body.dart';

class DetailsReportViewBody extends StatelessWidget {
  const DetailsReportViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsReportCubit, DetailsReportState>(
      builder: (context, state) {
        if(state is DetailsReportSuccess) {
          return Padding(
            padding: EdgeInsets.only(top: 56.0.h,),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: CustomScreenBody(
                title: state.report.report.name,
                textSecondButton: AppLocalizations.of(context).translate('New report'),
                onPressedFirst: () {},
                onPressedSecond: () {},
                body: Padding(
                  padding: EdgeInsets.only(top: 195.0.h,
                      left: 20.0.w,
                      right: 20.0.w,
                      bottom: 27.0.h),
                  child: CustomDetailsInformation(
                    imageWidth: 176.w,
                    imageHeight: 176.w,
                    image: state.report.report.secretary.photo,
                    name: state.report.report.secretary.name,
                    showFileTapText: true,
                    showAboutText: true,
                    aboutText: state.report.report.description,
                    onTap: () {},
                  ),
                ),
              ),
            ),
          );
        } else if(state is DetailsReportFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return CustomCircularProgressIndicator();
        }
      }
    );
  }
}
