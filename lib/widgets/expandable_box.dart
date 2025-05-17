import 'package:flutter/material.dart';

class ExpandableBox extends StatefulWidget {
  final String title;
  final List<Map<String, String>> data;
  final String columnKey;

  const ExpandableBox({
    super.key,
    required this.title,
    required this.data,
    required this.columnKey,
  });

  @override
  ExpandableBoxState createState() => ExpandableBoxState();
}

class ExpandableBoxState extends State<ExpandableBox> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(widget.title),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: widget.data.map((item) {
          return ListTile(
            title: Text(item[widget.columnKey] ?? 'N/A'),
          );
        }).toList(),
      ),
    );
  }
}
