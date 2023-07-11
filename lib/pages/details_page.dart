import 'package:flutter/material.dart';

import 'details_page.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class DetailsPage extends StatelessWidget {
  final List<dynamic> details;

  const DetailsPage({required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${details[1]}'),
            Text('Category: ${details[2]}'),
            Text('Address: ${details[3]}'),
            Text('City: ${details[4]}'),
            Text('Pincode: ${details[5]}'),
            Text('Phone 1: ${details[6]}'),
            Text('Phone 2: ${details[7]}'),
            Text('Mobile 1: ${details[8]}'),
            Text('Email: ${details[9]}'),
            Text('Website: ${details[10]}'),
          ],
        ),
      ),
    );
  }
}
