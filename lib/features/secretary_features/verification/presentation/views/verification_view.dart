import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/data/repos/trainer_repo_impl.dart';
import 'package:alhadara_dashboard/features/secretary_features/trainer/presentation/manager/create_trainer_cubit/create_trainer_cubit.dart';
import 'package:alhadara_dashboard/features/secretary_features/verification/data/repos/verification_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/verification_cubit/verification_cubit.dart';
import 'widgets/verification_view_body.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return VerificationCubit(
          getIt.get<VerificationRepoImpl>(),
        );
      },
      child: VerificationViewBody(),
    );
  }
}
