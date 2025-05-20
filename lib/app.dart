import 'package:flutter/material.dart';
import 'package:protocol_app/pages/monograph_display_page.dart';
import 'package:protocol_app/pages/profile.dart';
//import 'package:protocol_app/pages/uploads.dart';
import 'pages/home.dart';
import 'pages/list_view_page.dart';

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
        //'/uploads_page': (context) => const UploadsPage(), 
        '/profile_page': (context) => const ProfilePage(),
  },);

      }
  }
// Splash screen and app initialization combined
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 5)); 

    if (!mounted) return; 

    Navigator.pushReplacementNamed(context, '/home');
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

