import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onLogout;
  final String userRole; // Expected values: 'user', 'editor', 'admin', 'super_admin'

  const AppDrawer({
    super.key,
    required this.onLogout,
    required this.userRole,
  });

  bool get isAdmin => userRole == 'admin' || userRole == 'super_admin';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          right: BorderSide(color: Color(0xFFB21232), width: 2),
          top: BorderSide(color: Color(0xFFB21232), width: 2),
          bottom: BorderSide(color: Color(0xFFB21232), width: 2),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const Divider(),
              if (isAdmin)
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings),
                  title: const Text('Admin'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, '/admin_page');
                  },
                ),
              ListTile(
                leading: const Icon(Icons.schedule),
                title: const Text('Schedule'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/schedule_page');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: onLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
