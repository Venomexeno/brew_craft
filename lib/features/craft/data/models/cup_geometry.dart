import 'dart:ui';

import 'package:equatable/equatable.dart';

import '../../../../core/styles/app_colors.dart';

class CupGeometry extends Equatable {
  const CupGeometry({
    required this.top,
    required this.cupHeight,
    required this.topRadius,
    required this.bottomRadius,
    required this.rimThickness,
    required this.wallInset,
    required this.handleStrength,
    required this.ridgeStrength,
    required this.sleeveStrength,
    required this.glassiness,
    required this.bodyColor,
    required this.strokeColor,
  });

  final double top;
  final double cupHeight;
  final double topRadius;
  final double bottomRadius;
  final double rimThickness;
  final double wallInset;

  final double handleStrength;
  final double ridgeStrength;
  final double sleeveStrength;

  final double glassiness;
  final Color bodyColor;
  final Color strokeColor;

  const CupGeometry.mug()
      : this(
          top: 0.30,
          cupHeight: 0.48,
          topRadius: 0.27,
          bottomRadius: 0.23,
          rimThickness: 0.042,
          wallInset: 0.030,
          handleStrength: 1,
          ridgeStrength: 0,
          sleeveStrength: 0,
          glassiness: 0,
          bodyColor: AppColors.mugBody,
          strokeColor: AppColors.mugStroke,
        );

  const CupGeometry.glass()
      : this(
          top: 0.16,
          cupHeight: 0.66,
          topRadius: 0.195,
          bottomRadius: 0.155,
          rimThickness: 0.026,
          wallInset: 0.014,
          handleStrength: 0,
          ridgeStrength: 0,
          sleeveStrength: 0,
          glassiness: 1,
          bodyColor: AppColors.glassBody,
          strokeColor: AppColors.glassStroke,
        );

  const CupGeometry.paper()
      : this(
          top: 0.24,
          cupHeight: 0.54,
          topRadius: 0.30,
          bottomRadius: 0.175,
          rimThickness: 0.034,
          wallInset: 0.022,
          handleStrength: 0,
          ridgeStrength: 1,
          sleeveStrength: 1,
          glassiness: 0.05,
          bodyColor: AppColors.paperBody,
          strokeColor: AppColors.paperStroke,
        );

  CupGeometry lerp(CupGeometry other, double t) {
    t = t.clamp(0.0, 1.0);
    return CupGeometry(
      top: lerpDouble(top, other.top, t)!,
      cupHeight: lerpDouble(cupHeight, other.cupHeight, t)!,
      topRadius: lerpDouble(topRadius, other.topRadius, t)!,
      bottomRadius: lerpDouble(bottomRadius, other.bottomRadius, t)!,
      rimThickness: lerpDouble(rimThickness, other.rimThickness, t)!,
      wallInset: lerpDouble(wallInset, other.wallInset, t)!,
      handleStrength: lerpDouble(handleStrength, other.handleStrength, t)!,
      ridgeStrength: lerpDouble(ridgeStrength, other.ridgeStrength, t)!,
      sleeveStrength: lerpDouble(sleeveStrength, other.sleeveStrength, t)!,
      glassiness: lerpDouble(glassiness, other.glassiness, t)!,
      bodyColor: Color.lerp(bodyColor, other.bodyColor, t)!,
      strokeColor: Color.lerp(strokeColor, other.strokeColor, t)!,
    );
  }

  @override
  List<Object?> get props => [
        top,
        cupHeight,
        topRadius,
        bottomRadius,
        rimThickness,
        wallInset,
        handleStrength,
        ridgeStrength,
        sleeveStrength,
        glassiness,
        bodyColor,
        strokeColor,
      ];
}
