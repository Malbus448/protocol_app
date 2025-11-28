import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/app_shell.dart';
import '../utils/data_cache.dart';
import '../utils/responsive.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveConfig.of(context);
    return AppShell(
      title: 'Contacts',
      bottomNavIndex: 2,
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: DataCache.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contacts found.'));
          }

          final users = snapshot.data!;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: responsive.cardMaxWidth),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: responsive.padding),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final data = users[index].data() as Map<String, dynamic>;
                  final name = data['Name'] ?? 'N/A';
                  final email = data['Email'] ?? 'N/A';
                  final phone = data['Phone'] ?? 'N/A';
                  final photoUrl = data['photoUrl'];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            (photoUrl != null &&
                                    photoUrl.toString().trim().isNotEmpty)
                                ? NetworkImage(photoUrl)
                                : const AssetImage(
                                  'assets/images/profile_placeholder.jpeg',
                                ),
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(email),
                          const SizedBox(height: 2),
                          Text(phone),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
