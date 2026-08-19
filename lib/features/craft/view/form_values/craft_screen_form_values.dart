import 'package:flutter/material.dart';

import '../../../../core/models/form_values.dart';
import '../../data/models/brew.dart';
import '../screens/craft_screen.dart';

final class CraftScreenFormValues extends FormValues {
  late final AnimationController cta;
  late final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Set<Object?> get encapsulatedObjects => throw UnimplementedError();

  @override
  void init(covariant CraftScreenState screenState) {
    cta = AnimationController(
      vsync: screenState,
      duration: const Duration(milliseconds: 160),
      lowerBound: 0.96,
      upperBound: 1,
      value: 1,
    );
    orderNotifier = ValueNotifier(
      BrewOrder.initial(),
    );
  }
}
