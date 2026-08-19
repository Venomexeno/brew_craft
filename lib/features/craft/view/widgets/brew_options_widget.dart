import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../form_values/craft_screen_form_values.dart';
import 'brew_option_widget.dart';

class BrewOptionsWidget extends StatelessWidget {
  const BrewOptionsWidget({
    super.key,
    required this.formValues,
  });

  final CraftScreenFormValues formValues;

  @override
  Widget build(BuildContext context) {
    final options = [
      BrewOptionWidget.blend(formValues.orderNotifier),
      BrewOptionWidget.size(formValues.orderNotifier),
      BrewOptionWidget.vessel(formValues.orderNotifier),
      BrewOptionWidget.addons(formValues.orderNotifier),
    ];

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(
              0,
              (1 - t) * 18,
            ),
            child: child,
          ),
        );
      },
      child: DecoratedBox(
        decoration: _decoration(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 16,
            children: options,
          ),
        ),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      color: AppColors.panel,
      borderRadius: BorderRadius.circular(28),
      boxShadow: const [
        BoxShadow(
          color: AppColors.panelShadow,
          blurRadius: 28,
          offset: Offset(0, -8),
        ),
      ],
    );
  }
}
