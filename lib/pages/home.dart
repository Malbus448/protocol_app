import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/main_nav_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/screen_utils.dart'; // Assuming ScreenUtils is in this path

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Future<List<List<dynamic>>> loadCSV(String fileName) async {
    final rawData = await rootBundle.loadString('assets/$fileName');
    List<List<dynamic>> csvData = const CsvToListConverter().convert(rawData);
    return csvData;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/business');
        break;
      case 2:
        Navigator.pushNamed(context, '/school');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: ScreenUtils.width(context, 0.02),
            ),
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Handle menu press
              },
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildMainNavButton(context, 'Protocols', () async {
                var csvData = await loadCSV('csv/protocols.csv');
                if (context.mounted) {
                  Navigator.pushNamed(
                    context,
                    '/listviewpage',
                    arguments: {
                      'title': 'Protocols',
                      'csvData': csvData,
                    },
                  );
                }
              }),
              const SizedBox(height: 16),
              buildMainNavButton(context, 'Drug Monographs', () async {
                var csvData = await loadCSV('csv/drug_monograph.csv');
                if (context.mounted) {
                  Navigator.pushNamed(
                    context,
                    '/listviewpage',
                    arguments: {
                      'title': 'Drug Monographs',
                      'csvData': csvData,
                    },
                  );
                }
              }),
              const SizedBox(height: 16),
              buildMainNavButton(context, 'Operations', () async {
                var csvData = await loadCSV('csv/operations.csv');
                if (context.mounted) {
                  Navigator.pushNamed(
                    context,
                    '/listviewpage',
                    arguments: {
                      'title': 'Operations',
                      'csvData': csvData,
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
