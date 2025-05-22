import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pages/home.dart';
import 'pages/list_view_page.dart';
import 'pages/monograph_display_page.dart';
import 'pages/profile.dart';
import 'pages/login_page.dart';

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
        '/home': (context) => const HomePage(),
        '/listviewpage': (context) => const ListViewPage(),
        '/monograph_display_page': (context) => const MonographDisplayPage(),
        '/profile_page': (context) => const ProfilePage(),
        '/login': (context) => const LoginPage(),
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

  final user = FirebaseAuth.instance.currentUser;
  if (!mounted) return;

  if (user == null) {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
    return;
  }

  final uid = user.uid;
  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

  final data = doc.data();
  if (!doc.exists || data == null || !data.containsKey('role')) {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
    return;
  }

  final role = data['role'];

  if (!mounted) return;

  if (role == 'admin') {
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    Navigator.pushReplacementNamed(context, '/home');
  }
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
