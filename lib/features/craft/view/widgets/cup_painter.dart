import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/cup_geometry.dart';
import '../../data/models/cup_paint_data.dart';
import '../../../../core/styles/app_colors.dart';

class CupPainter extends CustomPainter {
  CupPainter(this.data);

  final CupPaintData data;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.shortestSide < 8) return;

    final g = data.geometry;
    final layout = _Layout(size, g);

    _drawContactShadow(canvas, layout, g);
    _drawHandle(canvas, layout, g);
    _drawBody(canvas, layout, g);
    _drawInterior(canvas, layout, g);
    _drawLiquidAndGarnish(canvas, layout, g);
    _drawRidges(canvas, layout, g);
    _drawSleeve(canvas, layout, g);
    _drawRim(canvas, layout, g);
    if (data.steam > 0.02 && data.ice < 0.4) {
      _drawSteam(canvas, layout);
    }
  }

  void _drawContactShadow(Canvas canvas, _Layout l, CupGeometry g) {
    final paint = Paint()
      ..color = AppColors.contactShadow
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(l.cx, l.botY + l.baseRy + 10),
        width: l.botR * 2.4,
        height: l.baseRy * 1.8,
      ),
      paint,
    );
  }

  Path _bodyPath(_Layout l, {required bool inner}) {
    final topR = inner ? l.innerTopR : l.topR;
    final botR = inner ? l.innerBotR : l.botR;
    final topY = inner ? l.innerTopY : l.topY;
    final botY = inner ? l.innerBotY : l.botY;
    final rimRy = inner ? l.rimRy * 0.72 : l.rimRy;
    final baseRy = inner ? l.baseRy * 0.72 : l.baseRy;

    final path = Path()
      ..moveTo(l.cx - topR, topY)
      ..lineTo(l.cx - botR, botY)
      ..arcTo(
        Rect.fromCenter(
            center: Offset(l.cx, botY), width: botR * 2, height: baseRy * 2),
        math.pi,
        math.pi,
        false,
      )
      ..lineTo(l.cx + topR, topY)
      ..arcTo(
        Rect.fromCenter(
            center: Offset(l.cx, topY), width: topR * 2, height: rimRy * 2),
        0,
        math.pi,
        false,
      )
      ..close();
    return path;
  }

  void _drawHandle(Canvas canvas, _Layout l, CupGeometry g) {
    if (g.handleStrength < 0.04) return;

    final joinY1 = ui.lerpDouble(l.topY, l.botY, 0.22)!;
    final joinY2 = ui.lerpDouble(l.topY, l.botY, 0.68)!;
    final joinX1 = _xOnWall(l, joinY1, right: true);
    final joinX2 = _xOnWall(l, joinY2, right: true);

    final reach = l.topR * 0.95 * g.handleStrength;
    final path = Path()
      ..moveTo(joinX1, joinY1)
      ..cubicTo(
        joinX1 + reach,
        joinY1 - l.rimRy * 2,
        joinX2 + reach * 1.05,
        joinY2 + l.rimRy,
        joinX2,
        joinY2,
      );

    final outer = Paint()
      ..color = Color.lerp(g.bodyColor, g.strokeColor, 0.25)!
          .withValues(alpha: g.handleStrength)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16 * g.handleStrength
      ..strokeCap = StrokeCap.round;
    final inner = Paint()
      ..color = Color.lerp(AppColors.parchment, g.bodyColor, 0.4)!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7 * g.handleStrength
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, outer);
    canvas.drawPath(path, inner);
  }

  double _xOnWall(_Layout l, double y, {required bool right}) {
    final t = ((y - l.topY) / (l.botY - l.topY)).clamp(0.0, 1.0);
    final r = ui.lerpDouble(l.topR, l.botR, t)!;
    return right ? l.cx + r : l.cx - r;
  }

  void _drawBody(Canvas canvas, _Layout l, CupGeometry g) {
    final path = _bodyPath(l, inner: false);
    final glass = g.glassiness;
    final fill = Paint()
      ..shader = ui.Gradient.linear(
        Offset(l.cx - l.topR, l.topY),
        Offset(l.cx + l.topR, l.botY),
        [
          Color.lerp(g.bodyColor, AppColors.highlight, 0.18 + glass * 0.2)!,
          g.bodyColor,
          Color.lerp(g.bodyColor, g.strokeColor, 0.35)!,
        ],
        const [0.0, 0.45, 1.0],
      );

    canvas.drawPath(path, fill);

    if (glass > 0.4) {
      canvas.drawPath(
        path,
        Paint()
          ..color = AppColors.highlight.withValues(alpha: 0.08 * glass)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
    }
  }

  void _drawInterior(Canvas canvas, _Layout l, CupGeometry g) {
    // Far wall of the opening — gives the cup depth before liquid arrives.
    final oval = Rect.fromCenter(
      center: Offset(l.cx, l.innerTopY),
      width: l.innerTopR * 2,
      height: l.rimRy * 1.55,
    );
    canvas.drawOval(
      oval,
      Paint()
        ..shader = ui.Gradient.linear(
          oval.topCenter,
          oval.bottomCenter,
          [
            Color.lerp(AppColors.mocha, g.strokeColor, g.glassiness)!
                .withValues(alpha: 0.55),
            Color.lerp(AppColors.espresso, g.bodyColor, 0.3)!
                .withValues(alpha: 0.28 + 0.4 * g.glassiness),
          ],
        ),
    );
  }

  void _drawLiquidAndGarnish(Canvas canvas, _Layout l, CupGeometry g) {
    final inner = _bodyPath(l, inner: true);
    canvas.save();
    canvas.clipPath(inner);

    if (data.fill > 0.012) {
      _drawLiquid(canvas, l);
    }
    if (data.foam > 0.02 && data.fill > 0.1) {
      _drawFoam(canvas, l);
    }
    if (data.ice > 0.02) {
      _drawIce(canvas, l);
    }
    if (data.drizzle > 0.02 && data.fill > 0.15) {
      _drawDrizzle(canvas, l);
    }

    canvas.restore();
  }

  void _drawLiquid(Canvas canvas, _Layout l) {
    final fillT = data.fill.clamp(0.0, 1.0);
    final surfaceY = l.yAt(fillT);
    final surfaceR = l.radiusAt(fillT);
    final amp =
        (6.0 * (0.35 + data.fill)) * (data.fill < 0.08 ? data.fill / 0.08 : 1);

    final path = Path()..moveTo(l.cx - surfaceR, surfaceY);
    const steps = 28;
    for (var i = 1; i <= steps; i++) {
      final u = i / steps;
      final x = l.cx - surfaceR + surfaceR * 2 * u;
      final y = surfaceY +
          math.sin(u * math.pi * 2.2 + data.wavePhase) *
              amp *
              math.sin(u * math.pi);
      path.lineTo(x, y);
    }
    path
      ..lineTo(l.cx + l.innerBotR, l.innerBotY)
      ..arcTo(
        Rect.fromCenter(
          center: Offset(l.cx, l.innerBotY),
          width: l.innerBotR * 2,
          height: l.baseRy * 1.2,
        ),
        0,
        math.pi,
        false,
      )
      ..close();

    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(l.cx, surfaceY - 8),
        Offset(l.cx, l.innerBotY + 8),
        [
          data.liquid,
          data.liquidDeep,
        ],
      );
    canvas.drawPath(path, paint);

    // Meniscus highlight riding the front of the wave.
    final hi = Paint()
      ..color = AppColors.highlight.withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final hiPath = Path();
    for (var i = 0; i <= steps; i++) {
      final u = i / steps;
      final x = l.cx - surfaceR + surfaceR * 2 * u;
      final y = surfaceY +
          math.sin(u * math.pi * 2.2 + data.wavePhase) *
              amp *
              math.sin(u * math.pi) +
          2;
      if (i == 0) {
        hiPath.moveTo(x, y);
      } else {
        hiPath.lineTo(x, y);
      }
    }
    canvas.drawPath(hiPath, hi);
  }

  void _drawFoam(Canvas canvas, _Layout l) {
    final fillT = data.fill.clamp(0.0, 1.0);
    final surfaceY = l.yAt(fillT);
    final surfaceR = l.radiusAt(fillT);
    final t = data.foam;
    final wobble = math.sin(data.wavePhase) * 2.5;

    final blobs = [
      Rect.fromCenter(
        center: Offset(l.cx + wobble, surfaceY - 6 * t),
        width: surfaceR * 1.55 * t,
        height: (18 + 10 * t) * t,
      ),
      Rect.fromCenter(
        center: Offset(l.cx - surfaceR * 0.28, surfaceY - 10 * t),
        width: surfaceR * 0.9 * t,
        height: 16 * t,
      ),
      Rect.fromCenter(
        center: Offset(l.cx + surfaceR * 0.3, surfaceY - 8 * t),
        width: surfaceR * 0.7 * t,
        height: 14 * t,
      ),
    ];

    final tSafe = t.clamp(0.0, 1.0);
    final cream = Paint()
      ..color = AppColors.foamCream.withValues(alpha: 0.92 * tSafe);
    final edge = Paint()
      ..color = AppColors.foamEdge.withValues(alpha: 0.55 * tSafe)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final r in blobs) {
      canvas.drawOval(r, cream);
      canvas.drawOval(r, edge);
    }

    // Micro-bubbles.
    final rng = math.Random(7);
    final bubble = Paint()
      ..color = AppColors.highlight.withValues(alpha: 0.55 * tSafe);
    for (var i = 0; i < 10; i++) {
      final u = rng.nextDouble() * 2 - 1;
      final x = l.cx + u * surfaceR * 0.7;
      final y = surfaceY - 4 - rng.nextDouble() * 12 * t;
      canvas.drawCircle(Offset(x, y), 1.4 + rng.nextDouble() * 1.6, bubble);
    }
  }

  void _drawIce(Canvas canvas, _Layout l) {
    final fillT = math.max(data.fill, 0.35);
    final surfaceY = l.yAt(fillT);
    final surfaceR = l.radiusAt(fillT);
    final t = data.ice;

    const cubes = [
      (dx: -0.32, delay: 0.00, rot: -0.22, size: 22.0, depth: 6.0),
      (dx: 0.18, delay: 0.16, rot: 0.38, size: 26.0, depth: 10.0),
      (dx: -0.04, delay: 0.30, rot: -0.08, size: 18.0, depth: 4.0),
    ];

    for (final c in cubes) {
      final local = data.iceLanding
          ? Curves.bounceOut
              .transform(((t - c.delay) / (1 - c.delay)).clamp(0.0, 1.0))
          : t;
      final startY = l.topY - 70;
      final endY = surfaceY - c.depth;
      final y = data.iceLanding ? ui.lerpDouble(startY, endY, local)! : endY;
      final x = l.cx + surfaceR * c.dx;
      final s = c.size * (0.85 + 0.15 * t);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(c.rot);
      final rect =
          Rect.fromCenter(center: Offset.zero, width: s, height: s * 0.82);
      final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(4));
      canvas.drawRRect(
        rrect,
        Paint()
          ..shader = ui.Gradient.linear(
            rect.topLeft,
            rect.bottomRight,
            [
              AppColors.iceHighlight.withValues(alpha: 0.95 * t),
              AppColors.iceShadow.withValues(alpha: 0.85 * t),
            ],
          ),
      );
      canvas.drawRRect(
        rrect.deflate(2),
        Paint()
          ..color = AppColors.highlight.withValues(alpha: 0.45 * t)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
      canvas.drawLine(
        Offset(-s * 0.2, -s * 0.15),
        Offset(s * 0.15, s * 0.1),
        Paint()
          ..color = AppColors.highlight.withValues(alpha: 0.55 * t)
          ..strokeWidth = 1.4
          ..strokeCap = StrokeCap.round,
      );
      canvas.restore();
    }
  }

  void _drawDrizzle(Canvas canvas, _Layout l) {
    final fillT = data.fill.clamp(0.0, 1.0);
    final surfaceY = l.yAt(fillT);
    final surfaceR = l.radiusAt(fillT);
    final t = data.drizzle;
    final endY = ui.lerpDouble(surfaceY, l.innerBotY - 8, 0.72)!;

    final syrup = Path()
      ..moveTo(l.cx - surfaceR * 0.15, surfaceY + 2)
      ..cubicTo(
        l.cx + surfaceR * 0.55,
        surfaceY + 16,
        l.cx - surfaceR * 0.6,
        surfaceY + 32,
        l.cx + surfaceR * 0.12,
        surfaceY + 48,
      )
      ..cubicTo(
        l.cx + surfaceR * 0.5,
        surfaceY + 64,
        l.cx - surfaceR * 0.35,
        endY - 10,
        l.cx + 4,
        endY,
      );

    final ribbon = Path()
      ..moveTo(l.cx + surfaceR * 0.22, surfaceY + 6)
      ..cubicTo(
        l.cx - surfaceR * 0.4,
        surfaceY + 24,
        l.cx + surfaceR * 0.45,
        surfaceY + 40,
        l.cx - 6,
        ui.lerpDouble(surfaceY, endY, 0.7)!,
      );

    final paint = Paint()
      ..color = AppColors.syrup.withValues(alpha: 0.92)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final p in [syrup, ribbon]) {
      for (final metric in p.computeMetrics()) {
        canvas.drawPath(metric.extractPath(0, metric.length * t), paint);
      }
    }
  }

  void _drawRidges(Canvas canvas, _Layout l, CupGeometry g) {
    if (g.ridgeStrength < 0.04) return;
    final paint = Paint()
      ..color =
          AppColors.ridge.withValues(alpha: 0.28 * g.ridgeStrength)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    for (var i = 1; i <= 6; i++) {
      final t = i / 7;
      final y = ui.lerpDouble(l.topY + l.rimRy, l.botY - l.baseRy, t)!;
      final r = ui.lerpDouble(l.topR, l.botR, t)! * 0.96;
      canvas.drawOval(
        Rect.fromCenter(center: Offset(l.cx, y), width: r * 2, height: 7),
        paint,
      );
    }
  }

  void _drawSleeve(Canvas canvas, _Layout l, CupGeometry g) {
    if (g.sleeveStrength < 0.04) return;
    final y1 = ui.lerpDouble(l.topY, l.botY, 0.46)!;
    final y2 = ui.lerpDouble(l.topY, l.botY, 0.72)!;
    final r1 = ui.lerpDouble(l.topR, l.botR, 0.46)! + 3;
    final r2 = ui.lerpDouble(l.topR, l.botR, 0.72)! + 3;
    final path = Path()
      ..moveTo(l.cx - r1, y1)
      ..lineTo(l.cx + r1, y1)
      ..lineTo(l.cx + r2, y2)
      ..lineTo(l.cx - r2, y2)
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..color =
            AppColors.sleeve.withValues(alpha: 0.55 * g.sleeveStrength),
    );
    canvas.drawPath(
      path,
      Paint()
        ..color =
            AppColors.sleeveEdge.withValues(alpha: 0.35 * g.sleeveStrength)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  void _drawRim(Canvas canvas, _Layout l, CupGeometry g) {
    final oval = Rect.fromCenter(
      center: Offset(l.cx, l.topY),
      width: l.topR * 2,
      height: l.rimRy * 2,
    );
    canvas.drawOval(
      oval,
      Paint()
        ..color = Color.lerp(g.strokeColor, AppColors.highlight, 0.35)!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.2 - 1.2 * g.glassiness,
    );
    canvas.drawOval(
      oval.deflate(g.glassiness > 0.5 ? 1 : 2.4),
      Paint()
        ..color = g.bodyColor.withValues(alpha: 0.9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  void _drawSteam(Canvas canvas, _Layout l) {
    final origin = Offset(l.cx, l.topY - 10);
    const wisps = 8;
    for (var i = 0; i < wisps; i++) {
      final drift = (data.wavePhase / (math.pi * 2) + i * 0.125) % 1.0;
      final fade = math.sin(drift * math.pi);
      final opacity = fade * 0.78 * data.steam * (1 - data.ice);
      if (opacity <= 0.02) continue;

      final x = origin.dx + math.sin(drift * 5.6 + i * 1.85) * (16.0 + i * 3.4);
      final y = origin.dy - drift * 96;
      final rx = 10.0 + i * 1.8 + fade * 3;
      final ry = rx * 2.15;

      canvas.drawOval(
        Rect.fromCenter(center: Offset(x, y), width: rx * 2, height: ry),
        Paint()
          ..color = AppColors.steam.withValues(alpha: opacity)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 9),
      );
      canvas.drawCircle(
        Offset(x + math.sin(drift * 3 + i) * 3, y - ry * 0.18),
        rx * 0.55,
        Paint()
          ..color = AppColors.highlight.withValues(alpha: opacity * 0.62)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CupPainter oldDelegate) =>
      oldDelegate.data != data;
}

class _Layout extends Equatable {
  _Layout(Size size, CupGeometry g) {
    cx = size.width / 2;
    topY = size.height * g.top;
    botY = size.height * (g.top + g.cupHeight);
    topR = size.width * g.topRadius;
    botR = size.width * g.bottomRadius;
    rimRy = size.height * g.rimThickness;
    baseRy = botR * 0.34;
    wall = size.width * g.wallInset;
    innerTopR = math.max(4, topR - wall);
    innerBotR = math.max(4, botR - wall * 0.85);
    innerTopY = topY + rimRy * 0.35;
    innerBotY = botY - baseRy * 0.25;
  }

  late final double cx;
  late final double topY;
  late final double botY;
  late final double topR;
  late final double botR;
  late final double rimRy;
  late final double baseRy;
  late final double wall;
  late final double innerTopR;
  late final double innerBotR;
  late final double innerTopY;
  late final double innerBotY;

  double radiusAt(double t) => ui.lerpDouble(innerBotR, innerTopR, t)!;

  double yAt(double t) => ui.lerpDouble(innerBotY, innerTopY, t)!;

  @override
  List<Object?> get props => [
        cx,
        topY,
        botY,
        topR,
        botR,
        rimRy,
        baseRy,
        wall,
        innerTopR,
        innerBotR,
        innerTopY,
        innerBotY,
      ];
}
