import 'package:flutter/material.dart';
import '../widgets/app_shell.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      title: 'Administration',
      body: SizedBox.shrink(),
      bottomNavIndex: 0,
    );
  }
}
