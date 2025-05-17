import 'package:flutter/material.dart';
import '../widgets/main_nav_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontSize: 20,  // Adjust as needed
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildMainNavButton(context, 'Protocols', () {
                Navigator.pushNamed(
                  context,
                  '/listview',
                  arguments: {'title': 'Protocols'},
                );
              }),
              const SizedBox(height: 16),
              buildMainNavButton(context, 'Drug Monographs', () {
                Navigator.pushNamed(
                  context,
                  '/listview',
                  arguments: {
                    'title': 'Drug Monographs',
                    'csvPath': 'assets/csv/drug_monograph.csv'
                  },
                );
              }),
              const SizedBox(height: 16),
              buildMainNavButton(context, 'Operations', () {
                Navigator.pushNamed(
                  context,
                  '/listview',
                  arguments: {'title': 'Operations'},
                );
              }),
               const SizedBox(height: 16),
              buildMainNavButton(context, 'Checklists', () {
                Navigator.pushNamed(
                  context,
                  '/listview',
                  arguments: {'title': 'Checklists'},
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
