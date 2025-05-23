import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('User not logged in');
    }
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Profile'),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Failed to load profile.'));
          }

          final data = snapshot.data!.data()!;
          final name = data['Name'] ?? 'N/A';
          final base = data['Base'] ?? 'N/A';
          final email = data['Email'] ?? 'N/A';
          final phone = data['Phone'] ?? 'N/A';

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                          radius: 50,
                          backgroundImage: (data['photoUrl'] != null && data['photoUrl'].toString().trim().isNotEmpty)
                          ? NetworkImage(data['photoUrl'])
                          : const AssetImage('assets/images/profile_placeholder.jpeg') as ImageProvider,
                        ),
                  const SizedBox(height: 20),
                  Text('Name: $name', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Base: $base', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Email: $email', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text('Phone: $phone', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}
