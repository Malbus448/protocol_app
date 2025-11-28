import 'package:flutter/material.dart';

enum SizeClass { small, medium, large }

class ResponsiveConfig {
  final SizeClass size;
  final double bodyScale;
  final double padding;
  final double cardMaxWidth;

  ResponsiveConfig({
    required this.size,
    required this.bodyScale,
    required this.padding,
    required this.cardMaxWidth,
  });

  factory ResponsiveConfig.of(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1024) {
      return ResponsiveConfig(
        size: SizeClass.large,
        bodyScale: 1.1,
        padding: 24,
        cardMaxWidth: 720,
      );
    }
    if (width >= 600) {
      return ResponsiveConfig(
        size: SizeClass.medium,
        bodyScale: 1.05,
        padding: 20,
        cardMaxWidth: 560,
      );
    }
    return ResponsiveConfig(
      size: SizeClass.small,
      bodyScale: 1.0,
      padding: 16,
      cardMaxWidth: double.infinity,
    );
  }

  TextStyle scaleText(TextStyle base) {
    return base.copyWith(
      fontSize: (base.fontSize ?? 14) * bodyScale,
    );
  }
}
