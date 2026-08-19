enum CupSize {
  small('S', 'Small', 0.78, 0.62, 0),
  medium('M', 'Medium', 1.0, 0.74, 0.60),
  large('L', 'Large', 1.18, 0.84, 1.20);

  final String short;
  final String label;

  /// Elastic-scaled cup size.
  final double scale;

  /// How full the cup reads after a pour.
  final double fill;
  final double extra;

  const CupSize(this.short, this.label, this.scale, this.fill, this.extra);
}
