import 'package:flutter/material.dart';

enum Addon {
  foam('Foam', Icons.cloud_rounded, 0.40),
  ice('Ice', Icons.ac_unit_rounded, 0.35),
  caramel('Drizzle', Icons.water_drop_rounded, 0.55);

  final String label;
  final IconData icon;
  final double extra;

  const Addon(this.label, this.icon, this.extra);
}
