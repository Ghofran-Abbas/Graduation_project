import 'package:flutter/material.dart';

import 'widgets/announcement_c_details_view_body.dart';

class AnnouncementCDetailsView extends StatelessWidget {
  const AnnouncementCDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return AnnouncementCDetailsViewBody();
  }
}
