import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';

enum DrinkKind {
  espresso(
    'Espresso',
    AppColors.espressoPour,
    AppColors.espressoPourDeep,
    3.50,
  ),
  cappuccino(
    'Cappuccino',
    AppColors.cappuccinoPour,
    AppColors.cappuccinoPourDeep,
    4.25,
  ),
  mocha(
    'Mocha',
    AppColors.mochaPour,
    AppColors.mochaPourDeep,
    4.75,
  ),
  hotChocolate(
    'Hot Cocoa',
    AppColors.hotCocoaPour,
    AppColors.hotCocoaPourDeep,
    4.50,
  ),
  caramelLatte(
    'Caramel Latte',
    AppColors.caramelLattePour,
    AppColors.caramelLattePourDeep,
    5.10,
  );

  /// Surface of the pour.
  final Color liquid;

  /// Depth / shadow of the pour.
  final Color liquidDeep;
  final String label;
  final double price;

  const DrinkKind(this.label, this.liquid, this.liquidDeep, this.price);
}
