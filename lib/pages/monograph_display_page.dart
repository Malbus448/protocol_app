import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart';

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
        itemCount: headerRow.length,
        itemBuilder: (context, index) {
          final key = headerRow[index]?.toString() ?? 'N/A';
          final value = rowData[index]?.toString() ?? 'N/A';
          return ListTile(title: Text(key), subtitle: Text(value));
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
