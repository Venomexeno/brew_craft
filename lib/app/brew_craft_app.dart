import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../core/models/custom_scroll_behavior.dart';
import '../core/styles/app_theme.dart';
import '../features/craft/view/screens/craft_screen.dart';

class BrewCraftApp extends StatelessWidget {
  const BrewCraftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrewCraft',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      scrollBehavior: const CustomScrollBehavior(),
      home: const CraftScreen(),
      builder: (context, child) {
        final scaledChild = ResponsiveBreakpoints.builder(
          breakpoints: [
            const Breakpoint(start: 0, end: 750, name: MOBILE),
            const Breakpoint(start: 751, end: double.infinity, name: TABLET),
          ],
          child: Builder(
            builder: (context) => ResponsiveScaledBox(
              width: _scaleWidth(context).value,
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );

        return SafeArea(
          top: false,
          bottom: true,
          left: false,
          right: false,
          child: scaledChild,
        );
      },
    );
  }

  ResponsiveValue<double> _scaleWidth(BuildContext context) {
    return ResponsiveValue<double>(
      context,
      conditionalValues: const [
        Condition.between(start: 0, end: 550, value: 450),
        Condition.between(start: 551, end: 750, value: 750),
        Condition.between(start: 751, end: 1200, value: 1000),
        Condition.between(start: 1101, end: 1400, value: 1200),
        Condition.between(start: 1401, end: 9999, value: 1600),
      ],
      defaultValue: 375,
    );
  }
}
