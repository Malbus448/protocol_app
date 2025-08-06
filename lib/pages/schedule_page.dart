import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/schedule.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String? _scheduleTitle;

  @override
  void initState() {
    super.initState();
    _loadTitle();
  }

  Future<void> _loadTitle() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final teaam = userDoc.data()?['Teaam'];

    if (teaam != null) {
      setState(() {
        _scheduleTitle = '$teaam Schedule';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, _scheduleTitle ?? 'Schedule'),
      body: const ScheduleWidget(),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
