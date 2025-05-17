import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // To load CSV from assets
import 'package:csv/csv.dart';

class ListViewWidget extends StatefulWidget {
  final String csvPath;
  final int columnIndex;

  const ListViewWidget({super.key, required this.csvPath, this.columnIndex = 0});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  List<String> _allItems = [];
  List<String> _filteredItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCsvData();
  }

  void _loadCsvData() async {
  try {
    final rawData = await rootBundle.loadString(widget.csvPath);
    final cleanedData = rawData.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(cleanedData);

    // Extract the first column from each row and skip the header
    setState(() {
      _allItems = csvTable
          .skip(1) // Skip the header row
          .map((row) => row[0].toString()) // Take the first column
          .toList();
      _filteredItems = List.from(_allItems);
      _isLoading = false;
    });
  } catch (e) {
    setState(() {
      _allItems = ['Error loading CSV: ${widget.csvPath}'];
      _filteredItems = List.from(_allItems);
      _isLoading = false;
    });
  }
}

  void _filterItems(String query) {
    setState(() {
      _filteredItems = _allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator()) // Show loading indicator
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _filterItems,
                ),
              ),
              Expanded(
                child: _filteredItems.isEmpty
                    ? const Center(child: Text('No results found'))
                    : ListView.builder(
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_filteredItems[index]),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/listviewdisplay',
                                arguments: {'title': _filteredItems[index]},
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
  }
}
