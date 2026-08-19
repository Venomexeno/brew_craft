import 'package:flutter/material.dart';

import '../models/cup_geometry.dart';

enum Vessel {
  mug('Mug', Icons.coffee_rounded, CupGeometry.mug()),
  glass('Glass', Icons.local_bar_rounded, CupGeometry.glass()),
  paper('Paper', Icons.coffee_maker_outlined, CupGeometry.paper());

  final String label;
  final IconData icon;
  final CupGeometry geometry;

  const Vessel(this.label, this.icon, this.geometry);
}
