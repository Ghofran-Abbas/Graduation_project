import 'package:flutter/material.dart';

import 'widgets/announcement_a_details_view_body.dart';

class AnnouncementADetailsView extends StatelessWidget {
  const AnnouncementADetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return AnnouncementADetailsViewBody();
  }
}
