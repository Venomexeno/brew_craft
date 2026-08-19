import 'dart:ui';
import 'package:flutter/material.dart';

import '../../data/models/brew.dart';
import '../../data/models/cup_geometry.dart';
import '../../data/models/cup_paint_data.dart';

class AnimatedCupController extends ChangeNotifier {
  final ValueNotifier<BrewOrder> _orderNotifier;

  AnimatedCupController({
    required TickerProvider vsync,
    required this._orderNotifier,
  }) : _order = _orderNotifier.value {
    _sizeCtrl = _create(vsync, const Duration(milliseconds: 780), 1);
    _shapeCtrl = _create(vsync, const Duration(milliseconds: 640), 1);
    _fillCtrl = _create(vsync, const Duration(milliseconds: 980))..forward();
    _waveCtrl = _create(vsync, const Duration(milliseconds: 2200))..repeat();
    _idleCtrl = _create(vsync, const Duration(milliseconds: 2800))
      ..repeat(reverse: true);
    _foamCtrl = _create(
      vsync,
      const Duration(milliseconds: 620),
      _has(Addon.foam) ? 1 : 0,
    );
    _iceCtrl = _create(
      vsync,
      const Duration(milliseconds: 1100),
      _has(Addon.ice) ? 1 : 0,
    );
    _drizzleCtrl = _create(
      vsync,
      const Duration(milliseconds: 860),
      _has(Addon.caramel) ? 1 : 0,
    );

    _fromGeo = _toGeo = _order.vessel.geometry;
    _fromScale = _toScale = _order.size.scale;
    _fromLiquid = _toLiquid = _order.drink.liquid;
    _fromDeep = _toDeep = _order.drink.liquidDeep;
    _fromFill = 0;
    _toFill = _order.size.fill;

    _orderNotifier.addListener(_onOrderChanged);
  }

  BrewOrder _order;
  final List<AnimationController> _allCtrls = [];

  late final AnimationController _sizeCtrl,
      _shapeCtrl,
      _fillCtrl,
      _waveCtrl,
      _idleCtrl,
      _foamCtrl,
      _iceCtrl,
      _drizzleCtrl;

  late CupGeometry _fromGeo, _toGeo;
  late double _fromScale, _toScale, _fromFill, _toFill;
  late Color _fromLiquid, _toLiquid, _fromDeep, _toDeep;

  AnimationController _create(
    TickerProvider vsync,
    Duration duration, [
    double value = 0,
  ]) {
    final ctrl = AnimationController(
      vsync: vsync,
      duration: duration,
      value: value,
    )..addListener(notifyListeners);
    _allCtrls.add(ctrl);
    return ctrl;
  }

  bool _has(Addon addon) => _order.addons.contains(addon);

  double get idle => _idleCtrl.value;
  double get fillPour => Curves.easeOutCubic.transform(_fillCtrl.value);
  double get scale => lerpDouble(
    _fromScale,
    _toScale,
    Curves.elasticOut.transform(_sizeCtrl.value),
  )!;
  Color get glowLiquid => Color.lerp(_fromLiquid, _toLiquid, fillPour)!;

  CupGeometry get _lerpedGeo =>
      _fromGeo.lerp(_toGeo, Curves.easeInOutCubic.transform(_shapeCtrl.value));
  double get _lerpedFill => lerpDouble(
    _fromFill == 0 ? _toFill : _fromFill,
    _toFill,
    Curves.easeOutCubic.transform(_sizeCtrl.value),
  )!;

  CupPaintData get paintData {
    final iceOn = _has(Addon.ice);
    return CupPaintData(
      geometry: _lerpedGeo,
      fill: lerpDouble(0, _lerpedFill, fillPour)!,
      wavePhase: _waveCtrl.value * 6.28318530718,
      liquid: glowLiquid,
      liquidDeep: Color.lerp(_fromDeep, _toDeep, fillPour)!,
      foam: Curves.easeOutCubic.transform(_foamCtrl.value),
      ice: _iceCtrl.value,
      iceLanding: iceOn && _iceCtrl.status != AnimationStatus.reverse,
      drizzle: Curves.easeInOutCubic.transform(_drizzleCtrl.value),
      steam: iceOn ? 0 : (0.82 + idle * 0.18),
    );
  }

  void _onOrderChanged() {
    final next = _orderNotifier.value;

    if (_order.vessel != next.vessel) {
      _fromGeo = _lerpedGeo;
      _toGeo = next.vessel.geometry;
      _shapeCtrl.forward(from: 0);
    }

    if (_order.size != next.size) {
      _fromScale = scale;
      _toScale = next.size.scale;
      _fromFill = _lerpedFill;
      _toFill = next.size.fill;
      _sizeCtrl.forward(from: 0);
    }

    if (_order.drink != next.drink) {
      _fromLiquid = glowLiquid;
      _fromDeep = Color.lerp(_fromDeep, _toDeep, _fillCtrl.value)!;
      _toLiquid = next.drink.liquid;
      _toDeep = next.drink.liquidDeep;
      _fromFill = 0.12;
      _toFill = next.size.fill;
      _fillCtrl.forward(from: 0);
    }

    if (_order.addons != next.addons) {
      void play(AnimationController c, bool on) =>
          on ? c.forward() : c.reverse();
      play(_foamCtrl, next.addons.contains(Addon.foam));
      play(_iceCtrl, next.addons.contains(Addon.ice));
      play(_drizzleCtrl, next.addons.contains(Addon.caramel));
    }

    _order = next;
  }

  @override
  void dispose() {
    _orderNotifier.removeListener(_onOrderChanged);
    for (final ctrl in _allCtrls) {
      ctrl.dispose();
    }
    super.dispose();
  }
}
