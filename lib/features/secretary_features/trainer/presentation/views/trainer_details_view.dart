import 'package:flutter/material.dart';

import 'widgets/trainer_details_view_body.dart';

class TrainerDetailsView extends StatelessWidget {
  const TrainerDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return const TrainerDetailsViewBody();
  }
}
