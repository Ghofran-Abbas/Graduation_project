import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'side_bar.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Row(
        children: [
          const SideBar(),
          Expanded(child: child)
        ],
      ),
    );
  }
}
