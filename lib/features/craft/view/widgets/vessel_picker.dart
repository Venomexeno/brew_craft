import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../data/models/brew.dart';

class VesselPicker extends StatelessWidget {
  const VesselPicker({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Vessel.values.map((vessel) {
        final selected = vessel == orderNotifier.value.vessel;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _VesselChip(
              vessel: vessel,
              selected: selected,
              onTap: (vessel) => orderNotifier.value = orderNotifier.value.changeVessel(vessel),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _VesselChip extends StatelessWidget {
  final bool selected;
  final ValueChanged<Vessel> onTap;
  final Vessel vessel;

  const _VesselChip({
    required this.vessel,
    required this.selected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(vessel),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        height: 52,
        decoration: brewChipDeco(selected: selected, radius: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              vessel.icon,
              size: 18,
              color: selected ? AppColors.honey : AppColors.cocoa,
            ),
            const SizedBox(width: 6),
            Text(
              vessel.label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: selected ? AppColors.foam : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
