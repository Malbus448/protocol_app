import 'package:flutter/material.dart';
import '../widgets/main_nav_button.dart';
import '../utils/screen_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Page',
          style: TextStyle(
            fontSize: ScreenUtils.fontSize(context, 0.035),
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildMainNavButton(context, 'Protocols', () {
                Navigator.pushNamed(context, '/listview',
                arguments: {'title': 'Protocols'},);
              }),
              const SizedBox(height: 16), // Spacing between buttons
              buildMainNavButton(context, 'Drug Monographs', () {
                Navigator.pushNamed(context, '/listview',
                arguments: {'title': 'Drug Monographs'},
                );
              }),
              const SizedBox(height: 16), // Spacing between buttons
              buildMainNavButton(context, 'Operations', () {
                Navigator.pushNamed(context, '/listview',
                arguments: {'title': 'Operations'},);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
 