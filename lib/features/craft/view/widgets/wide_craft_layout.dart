import 'package:flutter/material.dart';

import '../form_values/craft_screen_form_values.dart';
import 'animated_cup.dart';
import 'brew_button.dart';
import 'brew_craft_header.dart';
import 'brew_options_widget.dart';

class WideCraftLayout extends StatelessWidget {
  const WideCraftLayout({super.key, required this.formValues});

  final CraftScreenFormValues formValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      child: Column(
        spacing: 12,
        children: [
          BrewCraftHeader(orderNotifier: formValues.orderNotifier),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 20,
              children: [
                Expanded(child: _CupPreview(formValues: formValues)),
                Expanded(child: _OptionsPane(formValues: formValues)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CupPreview extends StatelessWidget {
  const _CupPreview({required this.formValues});

  final CraftScreenFormValues formValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 72, 8, 24),
      child: FittedBox(
        fit: BoxFit.contain,
        clipBehavior: Clip.none,
        child: SizedBox(
          width: 420,
          height: 420,
          child: AnimatedCup(orderNotifier: formValues.orderNotifier),
        ),
      ),
    );
  }
}

class _OptionsPane extends StatelessWidget {
  const _OptionsPane({required this.formValues});

  final CraftScreenFormValues formValues;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Expanded(child: BrewOptionsWidget(formValues: formValues)),
        BrewButton(formValues: formValues),
      ],
    );
  }
}
