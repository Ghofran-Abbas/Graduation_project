import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/secretary_features/course/presentation/manager/create_section_cubit/create_section_cubit.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles.dart';

class CustomMultipleCheckBox extends StatelessWidget {
  const CustomMultipleCheckBox({super.key, required this.isSelected, required this.option});

  final bool isSelected;
  final String option;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: isSelected,
          onChanged: (_) => context.read<MultiCheckboxCubit>().toggleItem(option),
          activeColor: Colors.transparent,
          checkColor: AppColors.mintGreen,
          side: BorderSide(
            color: isSelected ? AppColors.mintGreen : AppColors.t2,
            width: 1.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        Text(
          option,
          style: Styles.b2Normal(color: AppColors.t3),
        ),
      ],
    );
  }
}