import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pages/home.dart';
import 'pages/list_view_page.dart';
import 'pages/monograph_display_page.dart';
import 'pages/profile.dart';
import 'pages/login_page.dart';
import 'pages/uploads.dart';
import 'pages/contact.dart';
import 'pages/building.dart';
import 'pages/schedule.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/building_page': (context) => const BuildingPage(),
        '/profile_page': (context) => const ProfilePage(),
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
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;
    if (user == null) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    final uid = user.uid;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (!mounted) return;
    final data = doc.data();

    if (!doc.exists || data == null || !data.containsKey('role')) {
      Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    final role = data['role'];

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home'); // You can branch this based on role if needed
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
