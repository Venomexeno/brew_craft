import '../form_values/craft_screen_form_values.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../widgets/craft_screen_body.dart';

class CraftScreen extends StatefulWidget {
  const CraftScreen({super.key});

  @override
  State<CraftScreen> createState() => CraftScreenState();
}

class CraftScreenState extends State<CraftScreen>
    with SingleTickerProviderStateMixin {
  late final CraftScreenFormValues formValues;

  @override
  void initState() {
    super.initState();
    formValues = CraftScreenFormValues()..init(this);
  }

  @override
  void dispose() {
    formValues.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.pageGradient,
          ),
        ),
        child: CraftScreenBody(formValues: formValues),
      ),
    );
  }
}
