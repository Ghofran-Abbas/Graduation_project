import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles.dart';

import 'package:flutter/material.dart';

import '../text_icon_button.dart';

class CustomAbout extends StatelessWidget {
  const CustomAbout({super.key, this.labelText, required this.bodyText, this.bigText, this.maxLines, this.width, this.height, this.horizontal, this.vertical,});

  final String? labelText;
  final String bodyText;
  final bool? bigText;
  final int? maxLines;
  final double? width;
  final double? height;
  final double? horizontal;
  final double? vertical;

  static const int _maxLines = 10;

  @override
  Widget build(BuildContext context) {
    final textStyle = bigText ?? false
        ? Styles.b1Normal(color: AppColors.t1)
        : Styles.b2Normal(color: AppColors.t1);

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(text: bodyText, style: textStyle);
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: maxLines ?? _maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText ?? 'About',
              style: Styles.b2Bold(color: AppColors.t4),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Text(
              bodyText,
              style: textStyle,
              maxLines: maxLines ?? _maxLines,
              overflow: TextOverflow.ellipsis,
            ),
            if (isOverflowing)
              TextButton(
                onPressed: () => _showFullTextDialog(context, width, height, horizontal, vertical),
                child: const Text("See More"),
              ),
          ],
        );
      },
    );
  }

  void _showFullTextDialog(BuildContext context, double? width, double? height, double? horizontal, double? vertical) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Align(
          alignment: Alignment.topRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: width ?? 638.w,
              height: height ?? 478.h,
              margin: EdgeInsets.symmetric(horizontal: horizontal ?? 280.w, vertical: vertical ?? 255.h),
              padding: EdgeInsets.all(22.r),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: AlertDialog(
                scrollable: true,
                backgroundColor: AppColors.white,
                insetPadding: EdgeInsets.all(0),
                content: Text(
                  bodyText,
                  style: bigText ?? false
                      ? Styles.b1Normal(color: AppColors.t1)
                      : Styles.b2Normal(color: AppColors.t1),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text("Close"),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
