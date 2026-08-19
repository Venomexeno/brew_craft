import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../form_values/craft_screen_form_values.dart';
import 'animated_cup.dart';
import 'atmoshpere.dart';
import 'brew_button.dart';
import 'brew_craft_header.dart';
import 'brew_options_widget.dart';

class CraftScreenBody extends StatelessWidget {
  const CraftScreenBody({super.key, required this.formValues});

  final CraftScreenFormValues formValues;

  @override
  Widget build(BuildContext context) {
    return Atmosphere(
      child: ResponsiveBreakpoints.of(context).isMobile
          ? _CompactCraftLayout(formValues: formValues)
          : _WideCraftLayout(formValues: formValues),
    );
  }
}

class _CompactCraftLayout extends StatelessWidget {
  const _CompactCraftLayout({required this.formValues});

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

class _WideCraftLayout extends StatelessWidget {
  const _WideCraftLayout({required this.formValues});

  final CraftScreenFormValues formValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .fromLTRB(20, 4, 20, 20),
      child: Column(
        spacing: 12,
        children: [
          BrewCraftHeader(orderNotifier: formValues.orderNotifier),
          Expanded(
            child: Row(
              crossAxisAlignment: .stretch,
              spacing: 20,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 72, 8, 24),
                    child: FittedBox(
                      fit: .contain,
                      clipBehavior: .none,
                      child: SizedBox(
                        width: 420,
                        height: 420,
                        child: AnimatedCup(
                          orderNotifier: formValues.orderNotifier,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: BrewOptionsWidget(
                          formValues: formValues,
                        ),
                      ),
                      BrewButton(formValues: formValues),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
