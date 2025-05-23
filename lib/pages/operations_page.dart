import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class OperationsPage extends StatelessWidget {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Operations'),
      body: Center(
        child: Text('Operations Page'),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
