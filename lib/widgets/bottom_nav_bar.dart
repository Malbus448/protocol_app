import 'dart:ui';

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

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
    final isDark = theme.brightness == Brightness.dark;
    final overlayColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.9)
        : colorScheme.surface.withValues(alpha: 0.92);
    final borderColor = Colors.black.withValues(alpha: 0.12);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: overlayColor,
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
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
              unselectedItemColor:
                  theme.bottomNavigationBarTheme.unselectedItemColor,
              onTap: (index) => _onItemTapped(context, index),
            ),
          ),
        ),
      ),
    );
  }
}
