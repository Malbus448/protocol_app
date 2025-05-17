import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final List<List<dynamic>> csvData;
  final String title;

  const CustomListView({super.key, required this.csvData, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: csvData.length,
      itemBuilder: (context, index) {
        // Ensure the row has at least one element before accessing
        if (csvData[index].isEmpty) {
          return const ListTile(
            title: Text("Invalid data"),
          );
        }

        // Get the title from the first column
        final title = csvData[index][0]?.toString() ?? 'N/A';

        return ListTile(
          title: Text(title),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/monograph_display_page',
              arguments: {
                'rowData': csvData[index],  // Pass the entire row data
              },
            );
          },
        );
      },
    );
  }
}
