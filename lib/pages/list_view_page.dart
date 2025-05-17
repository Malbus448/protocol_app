import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final title = args['title'];
    final csvData = args['csvData'] as List<List<dynamic>>;

    return Scaffold(
      appBar: customAppBar(context, title),
      body: ListView.builder(
        itemCount: csvData.length,
        itemBuilder: (context, index) {
          // Displaying the first column for simplicity
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(csvData[index][0].toString()),  // Adjust to display your preferred column
            ),
          );
        },
      ),
    );
  }
}
