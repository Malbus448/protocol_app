import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/app_shell.dart';

class BaseProfilePage extends StatelessWidget {
  const BaseProfilePage({super.key});

  Future<List<Map<String, dynamic>>> fetchAllBases() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('baseinfo').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name = data['Name'] ?? 'N/A';
    final location = data['Location'] ?? 'N/A';
    final address = data['Address'] ?? 'N/A';
    final doorCode = data['Door Code'] ?? 'N/A';
    final info = data['Additional Information'] ?? 'N/A';

    return AppShell(
      title: name,
      bottomNavIndex: 0,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/images/profile_placeholder.jpeg',
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              Text('Location: $location', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Address: $address', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text(
                'Door Code: $doorCode',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Additional Info: $info',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
