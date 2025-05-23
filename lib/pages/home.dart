import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/main_nav_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/app_drawer.dart';
import '../utils/screen_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<List<dynamic>>> loadCSV(String fileName) async {
    final rawData = await rootBundle.loadString('assets/$fileName');
    return const CsvToListConverter().convert(rawData);
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(onLogout: _logout),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE5E5E5)
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: ScreenUtils.width(context, 0.02),
            ),
            child: IconButton(
              icon: const Icon(Icons.menu),
              color: Color(0xFFE5E5E5),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Color(0xFF2A5F8B),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildMainNavButton(context, 'Protocols', () async {
                var csvData = await loadCSV('csv/protocols.csv');
                if (!context.mounted) return;
                Navigator.pushNamed(
                  context,
                  '/listviewpage',
                  arguments: {'title': 'Protocols', 'csvData': csvData},
                );
              }),
              const SizedBox(height: 16),
              buildMainNavButton(context, 'Drug Monographs', () async {
                var csvData = await loadCSV('csv/drug_monograph.csv');
                if (!context.mounted) return;
                Navigator.pushNamed(
                  context,
                  '/listviewpage',
                  arguments: {'title': 'Drug Monographs', 'csvData': csvData},
                );
              }),
              const SizedBox(height: 16),
              buildMainNavButton(context, 'Operations', () async {
               // var csvData = await loadCSV('csv/operations.csv');
                if (!context.mounted) return;
                Navigator.pushNamed(
                  context,
                  '/operations_page',
                 // arguments: {'title': 'Operations', 'csvData': csvData},
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
