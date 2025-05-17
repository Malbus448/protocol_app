import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/main_nav_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // CSV loading function
  Future<List<List<dynamic>>> loadCSV(String fileName) async {
    final rawData = await rootBundle.loadString('assets/$fileName');
    List<List<dynamic>> csvData = const CsvToListConverter().convert(rawData);
    return csvData;
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
              const SizedBox(height: 16),
              buildMainNavButton(context, 'Checklists', () async {
                var csvData = await loadCSV('csv/checklist.csv');
                if (context.mounted) { 
                Navigator.pushNamed(
                  context,
                  '/listviewpage',
                  arguments: {
                    'title': 'Checklists',
                    'csvData': csvData,
                  },
                );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
