import 'package:flutter/material.dart';

import 'widgets/complete_details_view_body.dart';

class CompleteDetailsView extends StatelessWidget {
  const CompleteDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return CompleteDetailsViewBody();
  }
}
