import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/main_nav_button.dart';

class OperationsPage extends StatelessWidget {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Operations'),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildMainNavButton(context, 'Base Information', () {
                Navigator.pushNamed(
                  context,
                  '/listviewpage',
                  arguments: {'title': 'Base Information'},
                );
              }),
             buildMainNavButton(context, 'Other', () {
                Navigator.pushNamed(
                  context,
                  '/listviewpage',
                  arguments: {'title': 'Other'},
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}

