import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';

class MonographDisplayPage extends StatelessWidget {
  const MonographDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Use a try-catch to handle potential errors
    Map<String, dynamic> args;
    try {
      args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    } catch (e) {
      // Fallback in case arguments are null or improperly formatted
      args = {'title': 'Drug Monograph', 'rowData': [], 'headerRow': []};
    }

    final title = args['title'] ?? 'Drug Monograph';
    final rowData = args['rowData'] as List<dynamic>;
    final headerRow = args['headerRow'] as List<dynamic>;

    return Scaffold(
      appBar: customAppBar(context, title),
      body: ListView.builder(
        itemCount: rowData.length - 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(headerRow[index + 1]?.toString() ?? 'N/A'),
            subtitle: Text(rowData[index + 1]?.toString() ?? 'N/A'),
          );
        },
      ),
    );
  }
}

