import 'package:flutter/material.dart';

import '../../data/models/brew.dart';
import 'animated_price_widget.dart';
import 'drink_name_widget.dart';

class BrewCraftHeader extends StatelessWidget {
  const BrewCraftHeader({super.key, required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BREWCRAFT',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Compose your cup',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 6),
                DrinkNameWidget(orderNotifier: orderNotifier),
              ],
            ),
          ),
          AnimatedPrice(orderNotifier: orderNotifier),
        ],
      ),
    );
  }
}
