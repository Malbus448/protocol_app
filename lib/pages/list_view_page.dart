import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/list_view.dart';
import '../widgets/bottom_nav_bar.dart'; // Ensure this path is correct

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final title = args['title'] ?? 'Default Title';
    final csvData = args['csvData'] as List<List<dynamic>>? ?? [];

    return Scaffold(
      appBar: customAppBar(context, title),
      body: CustomListView(
        csvData: csvData,
        title: title,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0), // Change if needed
    );
  }
}
