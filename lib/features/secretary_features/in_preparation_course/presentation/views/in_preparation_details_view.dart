import 'package:flutter/material.dart';

import 'widgets/in_preparation_details_view_body.dart';

class DetailsInPreparationView extends StatelessWidget {
  const DetailsInPreparationView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return DetailsInPreparationViewBody();
  }
}
