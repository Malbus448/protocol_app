import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
//import '../widgets/schedule.dart'; // Make sure this file exists

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Schedule'),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
