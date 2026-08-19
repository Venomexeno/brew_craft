import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/styles/app_colors.dart';
import '../../data/models/brew.dart';

class AnimatedPrice extends StatelessWidget {
  const AnimatedPrice({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: orderNotifier,
      builder: (context, _) {
        final total = orderNotifier.value.total;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: total, end: total),
          duration: const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) {
            return Text('\$${value.toStringAsFixed(2)}', style: _priceStyle());
          },
        );
      },
    );
  }

  TextStyle _priceStyle() {
    return GoogleFonts.fraunces(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.caramel,
    );
  }
}
