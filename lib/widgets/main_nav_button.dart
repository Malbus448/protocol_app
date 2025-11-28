import 'package:flutter/material.dart';
import '../utils/screen_utils.dart';

Widget buildMainNavButton(BuildContext context, String text, VoidCallback onPressed) {
  final colorScheme = Theme.of(context).colorScheme;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: ScreenUtils.height(context, 0.01)),
    child: SizedBox(
      width: ScreenUtils.width(context, 0.8),
      height: ScreenUtils.height(context, 0.08),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtils.width(context, 0.05),
            vertical: ScreenUtils.height(context, 0.02),
          ),
        ),
        child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Ensures the text and icon are on opposite sides
  children: [
    Flexible(
      child: Text(
        text,
        style: TextStyle(
          fontSize: ScreenUtils.fontSize(context, 0.025),
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ),
    Icon(Icons.arrow_forward, size: ScreenUtils.height(context, 0.04),
          color: colorScheme.onPrimary,),
  ],
)
        ),
      ),
    );
}
