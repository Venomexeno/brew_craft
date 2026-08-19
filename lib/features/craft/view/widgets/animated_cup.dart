import 'package:flutter/material.dart';

import '../controllers/animated_cup_controller.dart';
import 'cup_painter.dart';
import '../../data/models/brew.dart';

class AnimatedCup extends StatefulWidget {
  const AnimatedCup({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  State<AnimatedCup> createState() => _AnimatedCupState();
}

class _AnimatedCupState extends State<AnimatedCup>
    with TickerProviderStateMixin {
  late final AnimatedCupController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimatedCupController(
      vsync: this,
      orderNotifier: widget.orderNotifier,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final idle = _controller.idle;
        return Transform.translate(
          offset: Offset(0, (idle - 0.5) * 6),
          child: Transform.rotate(
            angle: (idle - 0.5) * 0.035,
            child: Transform.scale(
              scale: _controller.scale,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 700),
                      width: 280,
                      height: 280,
                      decoration: _decoration(),
                    ),
                  ),
                  CustomPaint(
                    painter: CupPainter(_controller.paintData),
                    child: const SizedBox.expand(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _decoration() {
    final glow = _controller.glowLiquid;
    return BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [
          glow.withValues(alpha: 0.55),
          glow.withValues(alpha: 0.28),
          glow.withValues(alpha: 0),
        ],
        stops: const [0.0, 0.42, 1.0],
      ),
      boxShadow: [
        BoxShadow(
          color: glow.withValues(alpha: 0.38),
          blurRadius: 56,
          spreadRadius: 12,
        ),
      ],
    );
  }
}
