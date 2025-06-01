import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/create_trainer_cubit/create_trainer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/password_reset_repo_impl.dart';
import '../manager/password_reset_cubit/password_reset_cubit.dart';
import 'widgets/password_reset_view_body.dart';

class PasswordResetView extends StatelessWidget {
  const PasswordResetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PasswordResetCubit(
          getIt.get<PasswordResetRepoImpl>(),
        );
      },
      child: Scaffold(body: PasswordResetViewBody()),
    );
  }
}
