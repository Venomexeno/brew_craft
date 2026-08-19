

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'cup_geometry.dart';

class CupPaintData extends Equatable {
  const CupPaintData({
    required this.geometry,
    required this.fill,
    required this.wavePhase,
    required this.liquid,
    required this.liquidDeep,
    required this.foam,
    required this.ice,
    required this.iceLanding,
    required this.drizzle,
    required this.steam,
  });

  final CupGeometry geometry;
  final double fill;
  final double wavePhase;
  final Color liquid;
  final Color liquidDeep;
  final double foam; // 0–1
  final double ice; // opacity / presence 0–1
  final bool iceLanding; // bounce cubes vs fade-in-place
  final double drizzle; // 0–1 path draw
  final double steam; // 0–1 * looping phase rides on wavePhase

  @override
  List<Object?> get props => [
        geometry,
        fill,
        wavePhase,
        liquid,
        liquidDeep,
        foam,
        ice,
        iceLanding,
        drizzle,
        steam,
      ];
}

