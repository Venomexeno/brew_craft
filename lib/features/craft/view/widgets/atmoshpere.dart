import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';

class Atmosphere extends StatelessWidget {
  const Atmosphere({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _AtmospherePainter(),
      child: child,
    );
  }
}

class _AtmospherePainter extends CustomPainter {
  const _AtmospherePainter();

  @override
  void paint(Canvas canvas, Size size) {
    _blob(
      canvas,
      center: Offset(size.width - 40, 20),
      radius: 190,
      color: AppColors.caramel.withValues(alpha: 0.48),
    );
    _blob(
      canvas,
      center: Offset(size.width * 0.55, 80),
      radius: 120,
      color: AppColors.honey.withValues(alpha: 0.28),
    );
    _blob(
      canvas,
      center: Offset(40, size.height - 180),
      radius: 220,
      color: AppColors.mocha.withValues(alpha: 0.32),
    );
    _blob(
      canvas,
      center: Offset(size.width * 0.28, size.height - 90),
      radius: 140,
      color: AppColors.cocoa.withValues(alpha: 0.18),
    );
  }

  void _blob(
    Canvas canvas, {
    required Offset center,
    required double radius,
    required Color color,
  }) {
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            color,
            color.withValues(alpha: color.a * 0.45),
            color.withValues(alpha: 0),
          ],
          stops: const [0.0, 0.42, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
