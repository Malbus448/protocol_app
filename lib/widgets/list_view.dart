import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final String title;
  final List<List<dynamic>> csvData;

  const CustomListView({super.key, required this.title, required this.csvData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Padding around the entire list
      child: ListView.builder(
        itemCount: csvData.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12.0), // Gap between items
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha((0.3 * 255).toInt()),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Card(
              elevation: 2,
              margin: EdgeInsets.zero,
              child: ListTile(
                title: Text(
                  csvData[index][0].toString(), // Display the first column
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ),
              ),
            );
            }
            ),
        );
        }
      }
