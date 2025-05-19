import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/list_view.dart';
import '../widgets/bottom_nav_bar.dart'; // Ensure this path is correct

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  ListViewPageState createState() => ListViewPageState();
}

class ListViewPageState extends State<ListViewPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic based on the selected index
    // For example:
    // if (index == 0) Navigator.pushNamed(context, '/home');
    // if (index == 1) Navigator.pushNamed(context, '/business');
    // if (index == 2) Navigator.pushNamed(context, '/school');
  }

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
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
