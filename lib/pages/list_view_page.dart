import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/list_view.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Safely access arguments with null check
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final title = args['title'] ?? 'Default Title';  // Fallback title
    final csvData = args['csvData'] as List<List<dynamic>>? ?? [];  // Fallback empty list

    return Scaffold(
      appBar: customAppBar(context, title),
      body: CustomListView(
        csvData: csvData,
        title: title,
      ),
    );
  }
}
