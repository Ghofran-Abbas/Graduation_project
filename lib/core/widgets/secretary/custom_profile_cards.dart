/*
import 'package:alhadara_dashboard/core/utils/app_colors.dart';
import 'package:alhadara_dashboard/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/secretary/custom_over_loading_card.dart';

class CustomProfileCards extends StatelessWidget {
  const CustomProfileCards({super.key, required this.labelText, required this.cardCount, required this.onTapSeeMore, required this.widget});

  final String labelText;
  final int cardCount;
  final Function onTapSeeMore;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 52.h, bottom: 20.h, left: 20.w, right: 20.w,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: Styles.b2Bold(color: AppColors.t4),
          ),
          SizedBox(height: 10.h,),
          widget,
          CustomOverLoadingCard(
            cardCount: cardCount,
            onTapSeeMore: (){
              onTapSeeMore();
            },
            widget: widget,
          ),
        ],
      ),
    );
  }
}*/
