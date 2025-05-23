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
      case 3:
        Navigator.pushNamed(context, '/profile_page');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFE5E5E5),
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
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Color(0xFFB21232),
      unselectedItemColor: Color(0xFF2A5F8B),
      onTap: (index) => _onItemTapped(context, index),
    );
  }
}

