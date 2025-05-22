import 'package:flutter/material.dart';

import 'widgets/in_preparation_students_view_body.dart';

class InPreparationStudentsView extends StatelessWidget {
  const InPreparationStudentsView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return InPreparationStudentsViewBody();
  }
}
