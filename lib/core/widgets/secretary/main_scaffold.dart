import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utils/styles.dart';
import 'side_bar.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 950; // يمكن تعديل الحد حسب التصميم

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: isMobile
          ? AppBar(
        backgroundColor: AppColors.purple,
        title: Text(
          'Al Hadara',
          style: Styles.h2Bold(color: AppColors.white),
        ),
        iconTheme: IconThemeData(color: AppColors.white),
      )
          : null,
      drawer: isMobile ? const SideBar() : null,
      body: isMobile
          ? child // لا نحتاج إلى Row هنا لأن السايدبار في الـ drawer
          : Row(
        children: [
          const SideBar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}

