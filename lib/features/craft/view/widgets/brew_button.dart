import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../form_values/craft_screen_form_values.dart';

class BrewButton extends StatefulWidget {
  final CraftScreenFormValues formValues;

  const BrewButton({
    super.key,
    required this.formValues,
  });

  @override
  State<BrewButton> createState() => _BrewButtonState();
}

class _BrewButtonState extends State<BrewButton> {
  bool _brewed = false;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: widget.formValues.cta,
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: FilledButton(
          onPressed: _onPresed,
          style: _style,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            switchInCurve: Curves.easeOutBack,
            child: _Child(brewed: _brewed, formValues: widget.formValues),
          ),
        ),
      ),
    );
  }

  ButtonStyle get _style {
    return FilledButton.styleFrom(
      backgroundColor: AppColors.espresso,
      foregroundColor: AppColors.foam,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 0,
    );
  }

  void _onPresed() async {
    setState(() => _brewed = true);
    await widget.formValues.cta.reverse();
    await widget.formValues.cta.forward();
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    if (mounted) setState(() => _brewed = false);
  }
}

class _Child extends StatelessWidget {
  final bool brewed;
  final CraftScreenFormValues formValues;

  const _Child({required this.brewed, required this.formValues});

  @override
  Widget build(BuildContext context) {
    return brewed
        ? const Row(
            key: ValueKey('done'),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_rounded, color: AppColors.honey),
              SizedBox(width: 8),
              Text(
                'Crafted — enjoy',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          )
        : ListenableBuilder(
            listenable: formValues.orderNotifier,
            builder: (context, _) {
              final total = formValues.orderNotifier.value.total;
              return Text(
                'Brew it  ·  \$${total.toStringAsFixed(2)}',
                key: const ValueKey('brew'),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              );
            },
          );
  }
}
