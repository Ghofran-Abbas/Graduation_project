import 'package:flutter/material.dart';

import 'widgets/student_details_view_body.dart';

class StudentDetailsView extends StatelessWidget {
  const StudentDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return StudentDetailsViewBody();
  }
}
