import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Schedule'),
      body: const Center(
        child: Text(
          'Schedule content goes here',
          style: TextStyle(fontSize: 18),
        ),
      ),
     bottomNavigationBar: const BottomNavBar(currentIndex: 0),

    );
  }
}

