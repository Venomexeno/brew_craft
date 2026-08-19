import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/styles/app_colors.dart';
import '../../data/models/brew.dart';

class AnimatedPrice extends StatefulWidget {
  const AnimatedPrice({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  State<AnimatedPrice> createState() => _AnimatedPriceState();
}

class _AnimatedPriceState extends State<AnimatedPrice> {

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.orderNotifier,
      builder: (context, _) => TweenAnimationBuilder<double>(
        tween: Tween(begin: widget.orderNotifier.value.total, end: widget.orderNotifier.value.total),
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        builder: (context, value, _) {
          return Text(
            '\$${value.toStringAsFixed(2)}',
            style: GoogleFonts.fraunces(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.caramel,
            ),
          );
        },
      ),
    );
  }
}
