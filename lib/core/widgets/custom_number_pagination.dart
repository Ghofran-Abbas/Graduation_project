import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

class CustomNumberPagination extends StatelessWidget {
  const CustomNumberPagination({super.key, required this.numberPages, required this.initialPage, required this.onPageChange});

  final int numberPages;
  final int initialPage;
  final Function onPageChange;

  @override
  Widget build(BuildContext context) {
    return NumberPaginator(
      numberPages: numberPages ?? 1,
      initialPage: (initialPage ?? 1) - 1,
      onPageChange: (int index) {
        // index + 1 لأن API تبدأ من 1
        onPageChange(index);
      },
    );
  }
}
