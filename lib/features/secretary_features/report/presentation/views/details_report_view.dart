import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/report/data/repos/report_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/details_report_cubit/details_report_cubit.dart';
import '../manager/get_file_cubit/get_file_cubit.dart';
import 'widgets/details_report_view_body.dart';

class DetailsReportView extends StatelessWidget {
  const DetailsReportView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DetailsReportCubit(
              getIt.get<ReportRepoImpl>(),
            )..fetchDetailsReport(id: id);
          },
        ),
        BlocProvider(
          create: (context) {
            return GetFileCubit(
              getIt.get<ReportRepoImpl>(),
            );
          },
        ),
      ],
      child: const DetailsReportViewBody(),
    );
  }
}
