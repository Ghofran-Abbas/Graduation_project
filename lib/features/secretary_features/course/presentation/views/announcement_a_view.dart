import 'package:flutter/material.dart';

import 'widgets/announcement_a_view_body.dart';

class AnnouncementAView extends StatelessWidget {
  const AnnouncementAView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return AnnouncementAViewBody();
  }
}
