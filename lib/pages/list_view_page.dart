import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>? ?? {};
    final String title = args['title'] ?? 'Default Title';

    return Scaffold(
      appBar: customAppBar(context, title),
    );
  }
}

 