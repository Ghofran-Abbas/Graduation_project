import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/profile/data/repos/profile_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/points_cubit/points_cubit.dart';
import 'widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PointsCubit(
          getIt.get<ProfileRepoImpl>(),
        )..fetchPoints();
      },
      child: ProfileViewBody(),
    );
  }
}
