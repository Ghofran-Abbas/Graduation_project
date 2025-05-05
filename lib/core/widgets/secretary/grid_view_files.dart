import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class GridViewFiles extends StatelessWidget {
  const GridViewFiles({super.key, required this.cardCount, required this.fileName});

  final String fileName;
  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = ((screenWidth - 210) / 500).floor();
    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10.w, mainAxisExtent: 100.h),
      itemBuilder: (BuildContext context, int index) {
        return Align(child: FileItem(
          fileName: fileName,
          color: index%2 != 0 ? AppColors.white : AppColors.darkHighlightPurple,
        ));
      },
      itemCount: cardCount,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}

class FileItem extends StatelessWidget {
  const FileItem({super.key, required this.fileName, this.color});

  final String fileName;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 484.2.w,
      height: 100.h,
      color: color ?? AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.46.w),
        child: Row(
          children: [
            Icon(
              Icons.file_copy_outlined,
              color: AppColors.purple,
              size: 20.r,
            ),
            SizedBox(width: 30.w,),
            Text(
              fileName,
            ),
          ],
        ),
      ),
    );
  }
}