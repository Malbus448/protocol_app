import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/main_nav_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/app_drawer.dart';
import '../utils/screen_utils.dart';
import '../utils/user_session.dart';
import '../utils/data_cache.dart';

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
    final data = await UserSession.instance.loadCurrentUser();
    if (!mounted) return;
    setState(() {
      userRole = data?['role']?.toString().toLowerCase() ?? 'user';
    });
  }

  Future<List<List<dynamic>>> loadCSV(String fileName) async {
    final rawData = await rootBundle.loadString('assets/$fileName');
    return const CsvToListConverter().convert(rawData);
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    UserSession.instance.clear();
    DataCache.clear();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    if (userRole == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(onLogout: _logout, userRole: userRole!),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Page'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtils.width(context, 0.02)),
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
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
                  const SizedBox(height: 12),
                  buildMainNavButton(context, 'Drug Monographs', () async {
                    if (!context.mounted) return;
                    Navigator.pushNamed(
                      context,
                      '/listviewpage',
                      arguments: {
                        'title': 'Drug Monographs',
                        'source': 'drug_monographs',
                      },
                    );
                  }),
                  const SizedBox(height: 12),
                  buildMainNavButton(context, 'Operations', () async {
                    if (!context.mounted) return;
                    Navigator.pushNamed(
                      context,
                      '/listviewpage',
                      arguments: {
                        'title': 'Operations',
                        'source': 'operations',
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
