import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/decorations.dart';
import '../../data/models/brew.dart';

class VesselChip extends StatelessWidget {
  const VesselChip({
    super.key,
    required this.vessel,
    required this.selected,
    required this.onTap,
  });

  final Vessel vessel;
  final bool selected;
  final ValueChanged<Vessel> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        height: 52,
        decoration: _decoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(vessel.icon, size: 18, color: _iconColor()),
            const SizedBox(width: 6),
            Text(vessel.label, style: _labelStyle()),
          ],
        ),
      ),
    );
  }

  void _onTap() => onTap(vessel);

  BoxDecoration _decoration() {
    return brewChipDecoration(selected: selected, radius: 16);
  }

  Color _iconColor() {
    return selected ? AppColors.honey : AppColors.cocoa;
  }

  TextStyle _labelStyle() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: selected ? AppColors.foam : AppColors.ink,
    );
  }
}
