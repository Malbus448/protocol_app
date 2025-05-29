import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/list_view.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final pageTitle = args?['title'] ?? 'List View';
    final sourceCollection = args?['source'] ?? 'drug_monographs';
    final isBaseDescendant = args?['isBaseDescendant'] == true;


    return Scaffold(
      appBar: customAppBar(context, pageTitle),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection(sourceCollection)
            .orderBy('Name')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data found.'));
          }

          return CustomListView(
            docs: snapshot.data!.docs,
            title: pageTitle,
              displayKey: 'Name',
              extraKey: isBaseDescendant ? 'Location' : null,
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
