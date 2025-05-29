import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/main_nav_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/app_drawer.dart';
import '../utils/screen_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? userRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      userRole = doc.data()?['role']?.toString().toLowerCase() ?? 'user';
    });
  }

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
    if (userRole == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(onLogout: _logout, userRole: userRole!),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE5E5E5),
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
        backgroundColor: const Color(0xFF2A5F8B),
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
                if (!context.mounted) return;
                Navigator.pushNamed(
                  context,
                    '/listviewpage',
                  arguments: {'title': 'Drug Monographs', 'source': 'drug_monographs'},
                 );
               }),
              const SizedBox(height: 16),
                buildMainNavButton(context, 'Operations', () async {
                if (!context.mounted) return;
                  Navigator.pushNamed(
                  context,
                    '/listviewpage',
                  arguments: {'title': 'Operations', 'source': 'operations'},
                  );
               })
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
