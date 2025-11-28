import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protocol_app/pages/admin_page.dart';

import 'pages/home.dart';
import 'pages/list_view_page.dart';
import 'pages/monograph_display_page.dart';
import 'pages/profile.dart';
import 'pages/login_page.dart';
import 'pages/uploads.dart';
import 'pages/contact.dart';
import 'pages/building.dart';
import 'pages/schedule_page.dart';
import 'pages/base_profile_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryNavy = Color(0xFF0F213A);
    const surfaceStone = Color(0xFFF3F5F7);
    const accentTeal = Color(0xFF1CA6A8);
    const accentRed = Color(0xFFD64545);

    final lightScheme = ColorScheme.fromSeed(
      seedColor: primaryNavy,
      brightness: Brightness.light,
      primary: primaryNavy,
      secondary: accentTeal,
      tertiary: accentRed,
      background: surfaceStone,
      surface: Colors.white,
    );

    final darkScheme = ColorScheme.fromSeed(
      seedColor: primaryNavy,
      brightness: Brightness.dark,
      secondary: accentTeal,
      tertiary: accentRed,
      background: const Color(0xFF0B1526),
      surface: const Color(0xFF121E30),
    );

    TextTheme buildTextTheme(TextTheme base, Color onSurface) {
      final workSans = GoogleFonts.workSansTextTheme(base);
      return workSans.copyWith(
        titleLarge: workSans.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          color: onSurface,
        ),
        titleMedium: workSans.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          color: onSurface,
        ),
        bodyLarge: workSans.bodyLarge?.copyWith(
          fontSize: 16,
          height: 1.4,
          color: onSurface,
        ),
        bodyMedium: workSans.bodyMedium?.copyWith(
          fontSize: 15,
          height: 1.4,
          color: onSurface.withOpacity(0.9),
        ),
        labelLarge: workSans.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          color: onSurface,
        ),
      );
    }

    return MaterialApp(
      title: 'My Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightScheme,
        scaffoldBackgroundColor: surfaceStone,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: buildTextTheme(
          ThemeData.light().textTheme,
          lightScheme.onSurface,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: lightScheme.surfaceVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: lightScheme.surfaceVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: lightScheme.primary, width: 1.6),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryNavy,
          foregroundColor: Color(0xFFF7F8FA),
          centerTitle: true,
          elevation: 1,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryNavy,
            foregroundColor: lightScheme.onPrimary,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: surfaceStone,
          selectedItemColor: primaryNavy,
          unselectedItemColor: Color(0xFF4A5568),
          selectedIconTheme: IconThemeData(size: 24),
          unselectedIconTheme: IconThemeData(size: 24),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black.withOpacity(0.08),
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          iconColor: primaryNavy,
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        dividerColor: lightScheme.surfaceVariant,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkScheme,
        scaffoldBackgroundColor: darkScheme.background,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: buildTextTheme(
          ThemeData.dark().textTheme,
          darkScheme.onSurface,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: darkScheme.surfaceVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: darkScheme.surfaceVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: darkScheme.primary, width: 1.6),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: darkScheme.primaryContainer,
          foregroundColor: darkScheme.onPrimaryContainer,
          centerTitle: true,
          elevation: 1,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkScheme.primary,
            foregroundColor: darkScheme.onPrimary,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: darkScheme.surface,
          selectedItemColor: darkScheme.primary,
          unselectedItemColor: darkScheme.onSurfaceVariant,
          selectedIconTheme: const IconThemeData(size: 24),
          unselectedIconTheme: const IconThemeData(size: 24),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        cardTheme: CardTheme(
          color: darkScheme.surface,
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black.withOpacity(0.24),
        ),
        listTileTheme: ListTileThemeData(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          iconColor: darkScheme.primary,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: darkScheme.surface,
          surfaceTintColor: darkScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        dividerColor: darkScheme.surfaceVariant,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/admin_page': (context) => const AdminPage(),
        '/building_page': (context) => const BuildingPage(),
        '/profile_page': (context) => const ProfilePage(),
        '/base_profile_page': (context) => const BaseProfilePage(),
        '/uploads_page': (context) => const UploadsPage(),
        '/contacts_page': (context) => const ContactsPage(),
        '/listviewpage': (context) => const ListViewPage(),
        '/monograph_display_page': (context) => const MonographDisplayPage(),
        '/schedule_page': (context) => const SchedulePage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnAuthState();
  }

  Future<void> _navigateBasedOnAuthState() async {
    if (!mounted) return;
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      '/home',
    ); // You can branch this based on role if needed
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Loading...',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
