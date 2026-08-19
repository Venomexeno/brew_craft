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
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 18),
            child: child,
          ),
        );
      },
      child: DecoratedBox(
        decoration: _panelDecoration(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: _options(),
          ),
        ),
      ),
    );
  }

  List<Widget> _options() {
    final orderNotifier = formValues.orderNotifier;
    return [
      BrewOptionWidget.blend(orderNotifier),
      BrewOptionWidget.size(orderNotifier),
      BrewOptionWidget.vessel(orderNotifier),
      BrewOptionWidget.addons(orderNotifier),
    ];
  }

  BoxDecoration _panelDecoration() {
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
