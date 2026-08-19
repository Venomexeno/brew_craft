import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../enums/addon_enum.dart';
import '../enums/cup_size_enum.dart';
import '../enums/drink_kind_enum.dart';
import '../enums/vessel_enum.dart';

export '../enums/addon_enum.dart';
export '../enums/cup_size_enum.dart';
export '../enums/drink_kind_enum.dart';
export '../enums/vessel_enum.dart';

class BrewOrder extends Equatable {
  const BrewOrder({
    required this.drink,
    required this.size,
    required this.vessel,
    required this.addons,
  });

  final DrinkKind drink;
  final CupSize size;
  final Vessel vessel;
  final Set<Addon> addons;

  double get total =>
      drink.price +
      size.extra +
      addons.fold<double>(
        0,
        (sum, addon) => sum + addon.extra,
      );

  factory BrewOrder.initial() {
    return const BrewOrder(
      drink: DrinkKind.cappuccino,
      size: CupSize.medium,
      vessel: Vessel.mug,
      addons: {},
    );
  }

  BrewOrder changeDrink(DrinkKind drink) {
    return _copyWith(drink: drink);
  }

  BrewOrder changeSize(CupSize size) {
    return _copyWith(size: size);
  }

  BrewOrder changeVessel(Vessel vessel) {
    return _copyWith(vessel: vessel);
  }

  BrewOrder toggleAddon(Addon addon) {
    final next = {...addons};
    next.contains(addon) ? next.remove(addon) : next.add(addon);
    return _copyWith(addons: next);
  }

  BrewOrder _copyWith({
    DrinkKind? drink,
    CupSize? size,
    Vessel? vessel,
    Set<Addon>? addons,
  }) {
    return BrewOrder(
      drink: drink ?? this.drink,
      size: size ?? this.size,
      vessel: vessel ?? this.vessel,
      addons: addons ?? this.addons,
    );
  }

  @override
  List<Object?> get props => [
    drink,
    size,
    vessel,
    addons,
  ];
}

/// Shared chip decoration so every selector feels like one system.
BoxDecoration brewChipDeco({required bool selected, double radius = 18}) {
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
