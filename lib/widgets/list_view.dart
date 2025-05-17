import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final List<List<dynamic>> csvData;
  final String title;

  const CustomListView({super.key, required this.csvData, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Skip the first row by adjusting the item count
      itemCount: csvData.length - 1,
      itemBuilder: (context, index) {
        // Offset the index by 1 to skip the first row
        final actualIndex = index + 1;

        // Ensure the row has at least one element before accessing
        if (csvData[actualIndex].isEmpty) {
          return const ListTile(
            title: Text("Invalid data"),
          );
        }

        // Get the title from the first column of the clicked item
        final clickedTitle = csvData[actualIndex][0]?.toString() ?? 'N/A';

        return ListTile(
          title: Text(clickedTitle),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/monograph_display_page',
              arguments: {
                'title': clickedTitle,   // Pass the clicked item as the title
                'rowData': csvData[actualIndex], 
                'headerRow': csvData[0], // Use the first row as header
              },
            );
          },
        );
      },
    );
  }
}
