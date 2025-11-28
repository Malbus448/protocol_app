import 'package:flutter/material.dart';
import '../utils/screen_utils.dart';

PreferredSizeWidget customAppBar(BuildContext context, String title) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return AppBar(
    title: Text(
      title,
      style: textTheme.titleLarge?.copyWith(
        fontSize: ScreenUtils.fontSize(context, 0.035),
        color: colorScheme.onPrimary,
      ),
    ),
    centerTitle: true,
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
  );
}
