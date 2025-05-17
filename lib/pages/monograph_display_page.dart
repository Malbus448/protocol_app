import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';

class MonographDisplayPage extends StatelessWidget {
  const MonographDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final title = args['title'] ?? 'Drug Monograph';  // Safely extract title
    final rowData = args['rowData'] as List<dynamic>;

    return Scaffold(
      appBar: customAppBar(context, title),
      body: ListView.builder(
        itemCount: rowData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Column ${index + 1}'),
            subtitle: Text(rowData[index]?.toString() ?? 'N/A'),
          );
        },
      ),
    );
  }
}
