import 'package:flutter/material.dart';

class ExpandableBox extends StatefulWidget {
  final String title;
  final List<Map<String, String>> data;
  final String columnKey;
  final int selectedIndex; // Add the missing parameter

  const ExpandableBox({
    super.key,
    required this.title,
    required this.data,
    required this.columnKey,
    required this.selectedIndex, // Include the selectedIndex parameter
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
        title: Text(
          // Display the specific column from the first row when collapsed
          _isExpanded
              ? widget.title
              : widget.data.isNotEmpty
              ? widget.data[0][widget.columnKey] ?? 'N/A'
              : 'N/A',
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          // Display the corresponding column from the selected item when expanded
          ListTile(
            title: Text(
              widget.data.isNotEmpty
                  ? widget.data[widget.selectedIndex][widget.columnKey] ?? 'N/A'
                  : 'N/A',
            ),
          ),
        ],
      ),
    );
  }
}
