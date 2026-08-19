import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/decorations.dart';
import '../../data/models/brew.dart';

class AddonToggleChip extends StatefulWidget {
  const AddonToggleChip({
    super.key,
    required this.addon,
    required this.selected,
    required this.onTap,
  });

  final Addon addon;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<AddonToggleChip> createState() => _AddonToggleChipState();
}

class _AddonToggleChipState extends State<AddonToggleChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );

  late final Animation<double> _bounce = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1, end: 1.12), weight: 35),
    TweenSequenceItem(tween: Tween(begin: 1.12, end: 0.94), weight: 30),
    TweenSequenceItem(tween: Tween(begin: 0.94, end: 1), weight: 35),
  ]).animate(CurvedAnimation(parent: _pop, curve: Curves.easeOut));

  @override
  void didUpdateWidget(covariant AddonToggleChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected && widget.selected) {
      _pop.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _pop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _bounce,
        builder: (context, child) {
          return Transform.scale(scale: _bounce.value, child: child);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          height: 52,
          decoration: _decoration(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.addon.icon, size: 16, color: _iconColor()),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  widget.addon.label,
                  overflow: TextOverflow.ellipsis,
                  style: _labelStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return brewChipDecoration(selected: widget.selected, radius: 16);
  }

  Color _iconColor() {
    return widget.selected ? AppColors.honey : AppColors.cocoa;
  }

  TextStyle _labelStyle() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: widget.selected ? AppColors.foam : AppColors.ink,
    );
  }
}
