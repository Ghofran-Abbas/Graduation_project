import 'package:alhadara_dashboard/core/utils/service_locator.dart';
import 'package:alhadara_dashboard/features/profile/data/repos/profile_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/details_gift_cubit/details_gift_cubit.dart';
import 'widgets/secretary_gift_details_view_body.dart';

class SecretaryGiftDetailsView extends StatelessWidget {
  const SecretaryGiftDetailsView({super.key, required this.giftId});

  final int giftId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return DetailsGiftCubit(
          getIt.get<ProfileRepoImpl>(),
        )..fetchDetailsGift(id: giftId);
      },
      child: SecretaryGiftDetailsViewBody(),
    );
  }
}
