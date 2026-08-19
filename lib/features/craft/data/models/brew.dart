import 'package:equatable/equatable.dart';

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
