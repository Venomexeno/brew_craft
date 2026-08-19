import 'package:flutter/material.dart';

import '../../data/models/brew.dart';
import 'size_chip.dart';

class SizePicker extends StatelessWidget {
  const SizePicker({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final size in CupSize.values)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizeChip(
                size: size,
                selected: size == orderNotifier.value.size,
                onTap: _onTap,
              ),
            ),
          ),
      ],
    );
  }

  void _onTap(CupSize size) {
    orderNotifier.value = orderNotifier.value.changeSize(size);
  }
}
