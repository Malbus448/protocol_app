import 'package:flutter/material.dart';

class ScreenUtils {
  static double width(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.width * fraction;
  }

  static double height(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.height * fraction;
  }

  static double fontSize(BuildContext context, double fraction) {
    return MediaQuery.of(context).size.height * fraction;
  }
}
