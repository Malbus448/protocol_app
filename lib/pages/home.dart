import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/main_nav_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/app_drawer.dart';
import '../utils/screen_utils.dart';
import '../utils/user_session.dart';
import '../utils/data_cache.dart';
import '../utils/responsive.dart';

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

    final responsive = ResponsiveConfig.of(context);

    return Scaffold(
      extendBody: true,
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F213A),
                  Color(0xFF1CA6A8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(responsive.padding),
                child: Container(
                  constraints: BoxConstraints(maxWidth: responsive.cardMaxWidth),
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.padding,
                    vertical: responsive.padding + 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: responsive.size == SizeClass.large ? 16 : 12,
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
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
