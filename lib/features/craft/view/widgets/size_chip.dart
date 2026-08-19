import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/decorations.dart';
import '../../data/models/brew.dart';

class SizeChip extends StatelessWidget {
  const SizeChip({
    super.key,
    required this.size,
    required this.selected,
    required this.onTap,
  });

  final CupSize size;
  final bool selected;
  final ValueChanged<CupSize> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedScale(
        scale: selected ? 1.0 : 0.96,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          height: 52,
          alignment: Alignment.center,
          decoration: _decoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(size.short, style: _shortStyle()),
              Text(size.label, style: _labelStyle()),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() => onTap(size);

  BoxDecoration _decoration() {
    return brewChipDecoration(selected: selected, radius: 16);
  }

  TextStyle _shortStyle() {
    return TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 16,
      color: selected ? AppColors.foam : AppColors.ink,
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: selected ? AppColors.honey : AppColors.inkSoft,
    );
  }
}
