import 'package:flutter/material.dart';

import '../../data/models/brew.dart';
import 'addon_toggle_chip.dart';

class AddonPicker extends StatelessWidget {
  const AddonPicker({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final addon in Addon.values)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: AddonToggleChip(
                addon: addon,
                selected: orderNotifier.value.addons.contains(addon),
                onTap: () => _onTap(addon),
              ),
            ),
          ),
      ],
    );
  }

  void _onTap(Addon addon) {
    orderNotifier.value = orderNotifier.value.toggleAddon(addon);
  }
}
