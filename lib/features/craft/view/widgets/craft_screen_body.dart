import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../form_values/craft_screen_form_values.dart';
import 'atmoshpere.dart';
import 'compact_craft_layout.dart';
import 'wide_craft_layout.dart';

class CraftScreenBody extends StatelessWidget {
  const CraftScreenBody({super.key, required this.formValues});

  final CraftScreenFormValues formValues;

  @override
  Widget build(BuildContext context) {
    return Atmosphere(
      child: ResponsiveBreakpoints.of(context).isMobile
          ? CompactCraftLayout(formValues: formValues)
          : WideCraftLayout(formValues: formValues),
    );
  }
}
