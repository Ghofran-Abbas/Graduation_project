import 'package:flutter/material.dart';

import 'widgets/section_students_view_body.dart';

class SectionStudentsView extends StatelessWidget {
  const SectionStudentsView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return SectionStudentsViewBody();
  }
}
