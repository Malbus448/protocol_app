import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart'; // Ensure this path is correct

class MonographDisplayPage extends StatelessWidget {
  const MonographDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args;
    try {
      args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    } catch (e) {
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
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
