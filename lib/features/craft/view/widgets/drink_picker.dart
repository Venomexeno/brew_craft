import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../data/models/brew.dart';

class DrinkPicker extends StatelessWidget {
  const DrinkPicker({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final drink in DrinkKind.values)
          _DrinkChip(
            drink: drink,
            selected: drink == orderNotifier.value.drink,
            onTap: _onTap,
          ),
      ],
    );
  }

  void _onTap(DrinkKind drink) {
    orderNotifier.value = orderNotifier.value.changeDrink(drink);
  }
}

class _DrinkChip extends StatelessWidget {
  const _DrinkChip({
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
      onTap: () => onTap(drink),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        width: 118,
        height: 86,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        decoration: brewChipDeco(selected: selected, radius: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
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
              ),
            ),
            const Spacer(),
            Text(
              drink.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
                color: selected ? AppColors.foam : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
