import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/user_session.dart';
import '../utils/data_cache.dart';
import 'app_drawer.dart';
import 'bottom_nav_bar.dart';

class AppShell extends StatefulWidget {
  final String title;
  final Widget body;
  final int? bottomNavIndex;
  final PreferredSizeWidget? customAppBar;

  const AppShell({
    super.key,
    required this.title,
    required this.body,
    this.bottomNavIndex,
    this.customAppBar,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  String _role = 'user';

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final data = await UserSession.instance.loadCurrentUser();
    if (!mounted) return;
    setState(() {
      _role = data?['role']?.toString().toLowerCase() ?? 'user';
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    UserSession.instance.clear();
    DataCache.clear();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final appBar = widget.customAppBar ??
        AppBar(
          title: Text(widget.title),
          centerTitle: true,
        );

    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(onLogout: _logout, userRole: _role),
      body: widget.body,
      bottomNavigationBar: widget.bottomNavIndex != null
          ? BottomNavBar(currentIndex: widget.bottomNavIndex!)
          : null,
    );
  }
}
