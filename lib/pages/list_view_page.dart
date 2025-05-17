import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/list_view.dart'; // Import the CustomListView widget

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final title = args['title'];
    final csvData = args['csvData'] as List<List<dynamic>>;

    return Scaffold(
      appBar: customAppBar(context, title),
      body: CustomListView(
        title: title,
        csvData: csvData,
      ),
    );
  }
}

