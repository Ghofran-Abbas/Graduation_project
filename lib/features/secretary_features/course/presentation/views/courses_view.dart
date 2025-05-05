import 'dart:developer';

import 'package:flutter/material.dart';

import 'widgets/courses_view_body.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    log(id.toString());
    return CoursesViewBody();
  }
}
