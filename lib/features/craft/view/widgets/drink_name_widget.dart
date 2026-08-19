import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../data/models/brew.dart';

class DrinkNameWidget extends StatelessWidget {
  const DrinkNameWidget({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: orderNotifier,
      builder: (context, _) {
        final drink = orderNotifier.value.drink;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          child: Text(
            drink.label,
            key: ValueKey(drink),
            style: _labelStyle(context),
          ),
        );
      },
    );
  }

  TextStyle? _labelStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.cocoa,
          fontWeight: FontWeight.w600,
        );
  }
}
