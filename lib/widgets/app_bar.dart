import 'package:flutter/material.dart';
import '../utils/screen_utils.dart';

PreferredSizeWidget customAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontSize: ScreenUtils.fontSize(context, 0.035),
        fontWeight: FontWeight.bold,
        color: Color(0xFFE5E5E5),
      ),
    ),
    centerTitle: true,
    backgroundColor: Color(0xFF2A5F8B),
  );
}
