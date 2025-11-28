import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/list_view.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/data_cache.dart';
import '../utils/responsive.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final pageTitle = args?['title'] ?? 'List View';
    final sourceCollection = args?['source'] ?? 'drug_monographs';
    final isBaseDescendant = args?['isBaseDescendant'] == true;
    final responsive = ResponsiveConfig.of(context);

    return Scaffold(
      appBar: customAppBar(context, pageTitle),
      body: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: DataCache.getCollectionOrderedByName(sourceCollection),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found.'));
          }

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: responsive.cardMaxWidth),
              child: CustomListView(
                docs: snapshot.data!,
                title: pageTitle,
                displayKey: 'Name',
                extraKey: isBaseDescendant ? 'Location' : null,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
