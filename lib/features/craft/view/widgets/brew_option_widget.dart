import 'package:flutter/material.dart';

import '../../data/models/brew.dart';
import 'drink_picker.dart';
import 'selection_label.dart';
import 'addon_picker.dart';
import 'size_picker.dart';
import 'vessel_picker.dart';

class BrewOptionWidget<T> extends StatelessWidget {
  final String label;
  final Widget Function() listBuilder;
  final ValueNotifier<BrewOrder> orderNotifier;

  const BrewOptionWidget._({
    super.key,
    required this.label,
    required this.listBuilder,
    required this.orderNotifier,
  });

  factory BrewOptionWidget.blend(ValueNotifier<BrewOrder> orderNotifier) {
    return BrewOptionWidget._(
      label: 'BLEND',
      orderNotifier: orderNotifier,
      listBuilder: () => DrinkPicker(orderNotifier: orderNotifier),
    );
  }

  factory BrewOptionWidget.size(ValueNotifier<BrewOrder> orderNotifier) {
    return BrewOptionWidget._(
      label: 'SIZE',
      orderNotifier: orderNotifier,
      listBuilder: () => SizePicker(orderNotifier: orderNotifier),
    );
  }

  factory BrewOptionWidget.vessel(ValueNotifier<BrewOrder> orderNotifier) {
    return BrewOptionWidget._(
      label: 'VESSEL',
      orderNotifier: orderNotifier,
      listBuilder: () => VesselPicker(orderNotifier: orderNotifier),
    );
  }

  factory BrewOptionWidget.addons(ValueNotifier<BrewOrder> orderNotifier) {
    return BrewOptionWidget._(
      label: 'ADD-ONS',
      orderNotifier: orderNotifier,
      listBuilder: () => AddonPicker(orderNotifier: orderNotifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: orderNotifier,
      builder: (context, selectionLabel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            selectionLabel!,
            listBuilder(),
          ],
        );
      },
      child: SectionLabel(label),
    );
  }
}
