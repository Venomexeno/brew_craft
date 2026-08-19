import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../data/models/brew.dart';

class SizePicker extends StatelessWidget {
  const SizePicker({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: CupSize.values.map((size) {
        final selected = size == orderNotifier.value.size;
        
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _SizeChip(
              size: size,
              selected: selected,
              onTap: (size) => orderNotifier.value = orderNotifier.value.changeSize(size),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SizeChip extends StatelessWidget {
  final bool selected;
  final ValueChanged<CupSize> onTap;
  final CupSize size;

  const _SizeChip({
    required this.size,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(size),
      child: AnimatedScale(
        scale: selected ? 1.0 : 0.96,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          height: 52,
          alignment: Alignment.center,
          decoration: brewChipDeco(selected: selected, radius: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                size.short,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: selected ? AppColors.foam : AppColors.ink,
                ),
              ),
              Text(
                size.label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: selected ? AppColors.honey : AppColors.inkSoft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
