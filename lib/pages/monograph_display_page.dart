import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_nav_bar.dart'; // Ensure this path is correct

class MonographDisplayPage extends StatefulWidget {
  const MonographDisplayPage({super.key});

  @override
  MonographDisplayPageState createState() => MonographDisplayPageState();
}

class MonographDisplayPageState extends State<MonographDisplayPage> {
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
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}


