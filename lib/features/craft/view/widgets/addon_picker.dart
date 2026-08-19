import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../data/models/brew.dart';

class AddonPicker extends StatelessWidget {
  const AddonPicker({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Addon.values
          .map(
            (addon) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _AddonToggle(
                  addon: addon,
                  selected: orderNotifier.value.addons.contains(addon),
                  onTap: () => _onTap(addon),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void _onTap(Addon addon) {
    orderNotifier.value = orderNotifier.value.toggleAddon(addon);
  }
}

class _AddonToggle extends StatefulWidget {
  const _AddonToggle({
    required this.addon,
    required this.selected,
    required this.onTap,
  });

  final Addon addon;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_AddonToggle> createState() => _AddonToggleState();
}

class _AddonToggleState extends State<_AddonToggle>
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
  void didUpdateWidget(covariant _AddonToggle oldWidget) {
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
        builder: (context, child) => Transform.scale(scale: _bounce.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          height: 52,
          decoration: brewChipDeco(selected: widget.selected, radius: 16),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.addon.icon,
                size: 16,
                color: widget.selected ? AppColors.honey : AppColors.cocoa,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  widget.addon.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: widget.selected ? AppColors.foam : AppColors.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
