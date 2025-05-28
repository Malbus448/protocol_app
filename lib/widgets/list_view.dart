import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomListView extends StatelessWidget {
  final List<QueryDocumentSnapshot> docs;
  final String title;

  const CustomListView({super.key, required this.docs, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data() as Map<String, dynamic>;
        final itemTitle = data['Name'] ?? 'Untitled'; // assuming 'Name' is your primary display field

        return ListTile(
          title: Text(itemTitle),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/monograph_display_page',
              arguments: {
                'title': itemTitle,
                'rowData': data.values.toList(),
                'headerRow': data.keys.toList(),
              },
            );
          },
        );
      },
    );
  }
}
