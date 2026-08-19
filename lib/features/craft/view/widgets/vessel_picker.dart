import 'package:flutter/material.dart';

import '../../data/models/brew.dart';
import 'vessel_chip.dart';

class VesselPicker extends StatelessWidget {
  const VesselPicker({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final vessel in Vessel.values)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: VesselChip(
                vessel: vessel,
                selected: vessel == orderNotifier.value.vessel,
                onTap: _onTap,
              ),
            ),
          ),
      ],
    );
  }

  void _onTap(Vessel vessel) {
    orderNotifier.value = orderNotifier.value.changeVessel(vessel);
  }
}
