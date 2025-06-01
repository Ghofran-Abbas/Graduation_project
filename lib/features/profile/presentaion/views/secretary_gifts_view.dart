import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/profile/data/repos/profile_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/gifts_cubit/gifts_cubit.dart';
import 'widgets/secretary_gifts_view_body.dart';

class SecretaryGiftsView extends StatelessWidget {
  const SecretaryGiftsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GiftsCubit(
          getIt.get<ProfileRepoImpl>()
        )..fetchGifts(page: 1);
      },
      child: SecretaryGiftsViewBody(),
    );
  }
}
