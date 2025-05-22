import 'package:flutter/material.dart';

import 'widgets/complete_students_view_body.dart';

class CompleteStudentsView extends StatelessWidget {
  const CompleteStudentsView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return CompleteStudentsViewBody();
  }
}
