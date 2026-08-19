import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';

BoxDecoration brewChipDecoration({
  required bool selected,
  double radius = 18,
}) {
  return BoxDecoration(
    color: selected ? AppColors.espresso : AppColors.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(
      color: selected ? AppColors.espresso : AppColors.creamDeep,
      width: 1.2,
    ),
    boxShadow: [
      BoxShadow(
        color: selected
            ? AppColors.espresso.withValues(alpha: 0.22)
            : AppColors.shadow,
        blurRadius: selected ? 16 : 8,
        offset: const Offset(0, 6),
      ),
    ],
  );
}
