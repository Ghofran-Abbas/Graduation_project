import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_paginator/number_paginator.dart';

class CustomNumberPagination extends StatelessWidget {
  const CustomNumberPagination({super.key, required this.numberPages, required this.initialPage, required this.onPageChange});

  final int numberPages;
  final int initialPage;
  final Function onPageChange;

  @override
  Widget build(BuildContext context) {
    return numberPages != 1 ? NumberPaginator(
      numberPages: numberPages,
      initialPage: (initialPage) - 1,
      onPageChange: (int index) {
        // index + 1 لأن API تبدأ من 1
        onPageChange(index);
      },
    ) : SizedBox(width: 0.w, height: 0.h,);
  }
}
