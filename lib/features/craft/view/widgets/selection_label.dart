import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 2),
      child: Text(text, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}