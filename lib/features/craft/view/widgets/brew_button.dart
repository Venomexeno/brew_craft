import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../data/models/brew.dart';
import '../form_values/craft_screen_form_values.dart';

class BrewButton extends StatefulWidget {
  const BrewButton({super.key, required this.formValues});

  final CraftScreenFormValues formValues;

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
          onPressed: _onPressed,
          style: _buttonStyle(),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            switchInCurve: Curves.easeOutBack,
            child: _brewed
                ? const _BrewedLabel()
                : _BrewItLabel(orderNotifier: widget.formValues.orderNotifier),
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return FilledButton.styleFrom(
      backgroundColor: AppColors.espresso,
      foregroundColor: AppColors.foam,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 0,
    );
  }

  Future<void> _onPressed() async {
    setState(() => _brewed = true);
    await widget.formValues.cta.reverse();
    await widget.formValues.cta.forward();
    await Future<void>.delayed(const Duration(milliseconds: 1600));
    if (mounted) setState(() => _brewed = false);
  }
}

class _BrewedLabel extends StatelessWidget {
  const _BrewedLabel();

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const ValueKey('done'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_rounded, color: AppColors.honey),
        const SizedBox(width: 8),
        Text('Crafted — enjoy', style: _labelStyle()),
      ],
    );
  }

  static TextStyle _labelStyle() {
    return const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);
  }
}

class _BrewItLabel extends StatelessWidget {
  const _BrewItLabel({required this.orderNotifier});

  final ValueNotifier<BrewOrder> orderNotifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: orderNotifier,
      builder: (context, _) {
        final total = orderNotifier.value.total;
        return Text(
          'Brew it  ·  \$${total.toStringAsFixed(2)}',
          key: const ValueKey('brew'),
          style: _labelStyle(),
        );
      },
    );
  }

  TextStyle _labelStyle() {
    return const TextStyle(fontWeight: FontWeight.w700, fontSize: 16);
  }
}
