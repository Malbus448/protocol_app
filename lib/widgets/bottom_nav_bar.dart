import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/building_page'); 
        break;
      case 2:
        Navigator.pushNamed(context, '/contacts_page'); 
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return BottomNavigationBar(
      backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_present),
          label: 'Assets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_page),
          label: 'Contacts',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
      onTap: (index) => _onItemTapped(context, index),
    );
  }
}
