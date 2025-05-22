import 'package:flutter/material.dart';

import 'widgets/announcement_c_view_body.dart';

class AnnouncementCView extends StatelessWidget {
  const AnnouncementCView({super.key, required this.sectionId});

  final int sectionId;

  @override
  Widget build(BuildContext context) {
    return AnnouncementCViewBody();
  }
}
