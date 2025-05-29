import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomListView extends StatelessWidget {
  final List<QueryDocumentSnapshot> docs;
  final String title;
  final String displayKey;
  final String? extraKey;

  const CustomListView({
    super.key,
    required this.docs,
    required this.title,
    required this.displayKey,
    this.extraKey,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data() as Map<String, dynamic>;

        final mainValue = data[displayKey] ?? '';
        final extraValue = extraKey != null && data.containsKey(extraKey)
            ? ' - ${data[extraKey]}'
            : '';
        final itemTitle = '$mainValue$extraValue';

        return ListTile(
          title: Text(itemTitle),
          onTap: () {
            const fieldOrder = [
              'Name',
              'Classification',
              'Mechanism of Action',
              'Typical Dose/Sequence',
              'Indications',
              'Contraindications',
            ];

            final orderedHeaderRow =
                fieldOrder.where((key) => data.containsKey(key)).toList();
            final orderedRowData =
                orderedHeaderRow.map((key) => data[key]).toList();

            if (title == 'Operations') {
              final newCollection = data['Target'];
              if (newCollection == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Missing target field in document'),
                  ),
                );
                return;
              }

              Navigator.pushNamed(
                context,
                '/listviewpage',
                arguments: {
                  'title': itemTitle,
                  'source': newCollection,
                  'isBaseDescendant': newCollection == 'baseinfo',
                },
              );
            } else if (title == 'Base Information') {
              Navigator.pushNamed(
                context,
                '/base_profile_page',
                arguments: data,
              );
            } else {
              Navigator.pushNamed(
                context,
                '/monograph_display_page',
                arguments: {
                  'title': itemTitle,
                  'headerRow': orderedHeaderRow,
                  'rowData': orderedRowData,
                },
              );
            }
          },
        );
      },
    );
  }
}
