import 'package:flutter/material.dart';

import '../form_values/craft_screen_form_values.dart';
import 'animated_cup.dart';
import 'brew_button.dart';
import 'brew_craft_header.dart';
import 'brew_options_widget.dart';

class CompactCraftLayout extends StatelessWidget {
  const CompactCraftLayout({super.key, required this.formValues});

  final CraftScreenFormValues formValues;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          BrewCraftHeader(orderNotifier: formValues.orderNotifier),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AnimatedCup(orderNotifier: formValues.orderNotifier),
            ),
          ),
          BrewOptionsWidget(formValues: formValues),
          Padding(
            padding: const EdgeInsets.all(16),
            child: BrewButton(formValues: formValues),
          ),
        ],
      ),
    );
  }
}
