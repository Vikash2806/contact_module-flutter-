import 'package:flutter/material.dart';

import 'details_page.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class NamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final names = args['names'] as List<String>;//: This line extracts the value associated with the key 'names' from the args map.
    final csvData = args['csvData'] as List<List<dynamic>>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Names'),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          final name = names[index];
          final details = csvData.firstWhere((row) => row[1] == name, orElse: () => []);

          return Container(
            margin: EdgeInsets.only(bottom: 8.0,top:8),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              tileColor: Colors.lightBlueAccent.shade100,
              title: Text(name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(details: details),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
