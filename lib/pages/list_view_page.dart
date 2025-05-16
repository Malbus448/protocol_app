import 'package:flutter/material.dart';
import '../utils/screen_utils.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {};
    final String title = args['title'] ?? 'Default Title';

    return Scaffold(
      appBar: AppBar(
        title: Text(title,
          style: TextStyle(
            fontSize: ScreenUtils.fontSize(context, 0.035),
            fontWeight: FontWeight.bold,
          ),),  // Display the passed title
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Welcome to the $title Page'),
      ),
    );
  }
}

 