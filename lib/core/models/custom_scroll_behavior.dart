import 'dart:ui';

import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,

    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
