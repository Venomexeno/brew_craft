import 'package:flutter/material.dart';

import '../../data/models/brew.dart';
import 'drink_chip.dart';

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
          DrinkChip(
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
