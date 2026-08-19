import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/decorations.dart';
import '../../data/models/brew.dart';

class DrinkChip extends StatelessWidget {
  const DrinkChip({
    super.key,
    required this.drink,
    required this.selected,
    required this.onTap,
  });

  final DrinkKind drink;
  final bool selected;
  final ValueChanged<DrinkKind> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        width: 118,
        height: 86,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        decoration: _decoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: _swatchDecoration(),
            ),
            const Spacer(),
            Text(
              drink.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _labelStyle(),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() => onTap(drink);

  BoxDecoration _decoration() {
    return brewChipDecoration(selected: selected, radius: 20);
  }

  BoxDecoration _swatchDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [drink.liquid, drink.liquidDeep],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      border: Border.all(
        color: selected ? AppColors.honey : AppColors.highlight,
        width: 1.5,
      ),
    );
  }

  TextStyle _labelStyle() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12.5,
      color: selected ? AppColors.foam : AppColors.ink,
    );
  }
}
